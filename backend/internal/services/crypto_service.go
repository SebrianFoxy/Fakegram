package services

import (
	"context"
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"fmt"
	"log"
	"strconv"

	"fakegram-api/internal/config"
	"fakegram-api/internal/models"

	"golang.org/x/crypto/argon2"
)

type CryptoService struct {
	masterKey    []byte
	argon2Time   uint32
	argon2Memory uint32
	argon2Threads uint8

	encryptKeyRepo EncryptionKeyRepository
	deviceRepo     UserDeviceRepository
	keyCache       KeyCacheService
}

func NewCryptoService(
	cfg *config.Config,
	encryptKeyRepo EncryptionKeyRepository,
	deviceRepo     UserDeviceRepository,
	keyCache       KeyCacheService,
	) (*CryptoService, error) {
	if cfg.MasterKey == "" {
		return nil, errors.New("MASTER_KEY is not configured")
	}

	masterKey, err := hex.DecodeString(cfg.MasterKey)
	if err != nil || len(masterKey) != 32 {
		return nil, fmt.Errorf("MASTER_KEY must be 64 hex characters (32 bytes), got %d bytes", len(masterKey))
	}

	time, _ := strconv.ParseUint(cfg.Argon2Time, 10, 32)
	memory, _ := strconv.ParseUint(cfg.Argon2Memory, 10, 32)
	threads, _ := strconv.ParseUint(cfg.Argon2Threads, 10, 8)

	return &CryptoService{
		masterKey:     masterKey,
		argon2Time:    uint32(time),
		argon2Memory:  uint32(memory),
		argon2Threads: uint8(threads),
		encryptKeyRepo: encryptKeyRepo,
		deviceRepo:     deviceRepo,
		keyCache:       keyCache,
	}, nil
}

func (s *CryptoService) InitUserKeys(ctx context.Context, userID, password string) error {
	encryptedKey, salt, publicKey, err := s.GenerateUserKeys(password)
	if err != nil {
		return fmt.Errorf("failed to generate keys: %w", err)
	}

	return s.encryptKeyRepo.CreateEncryptionKey(&models.CreateUserMasterKeyRequest{
		UserID:              userID,
		EncryptedPrivateKey: encryptedKey,
		PasswordSalt:        salt,
		PublicKey:           publicKey,
	})
}

func (s *CryptoService) GetOrCreateUserKey(ctx context.Context, userID, password string) (*models.UserMasterKey, error) {
	masterKey, err := s.encryptKeyRepo.GetByUserID(userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get master key: %w", err)
	}

	if masterKey != nil {
		return masterKey, nil
	}

	log.Printf("Creating encryption keys for existing user %s", userID)

	if err := s.InitUserKeys(ctx, userID, password); err != nil {
		return nil, err
	}

	masterKey, err = s.encryptKeyRepo.GetByUserID(userID)
	if err != nil {
		return nil, err
	}

	return masterKey, nil
}

func (s *CryptoService) GenerateUserKeys(password string) (encryptedPrivateKey, salt, publicKey string, err error) {
	saltBytes := make([]byte, 32)
	if _, err := rand.Read(saltBytes); err != nil {
		return "", "", "", fmt.Errorf("failed to generate salt: %w", err)
	}

	passwordKey := argon2.IDKey(
		[]byte(password),
		saltBytes,
		s.argon2Time,
		s.argon2Memory,
		s.argon2Threads,
		32, 
	)

	userMasterKey := make([]byte, 32)
	if _, err := rand.Read(userMasterKey); err != nil {
		return "", "", "", fmt.Errorf("failed to generate user master key: %w", err)
	}

	nonce := make([]byte, 12)
	if _, err := rand.Read(nonce); err != nil {
		return "", "", "", err
	}

	block, err := aes.NewCipher(passwordKey)
	if err != nil {
		return "", "", "", err
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", "", "", err
	}

	encryptedKey := aesgcm.Seal(nonce, nonce, userMasterKey, nil)

	return base64.StdEncoding.EncodeToString(encryptedKey),
		base64.StdEncoding.EncodeToString(saltBytes),
		base64.StdEncoding.EncodeToString(userMasterKey[:16]),
		nil
}

func (s *CryptoService) DeriveUserKey(password, saltBase64, encryptedKeyBase64 string) ([]byte, error) {
	salt, err := base64.StdEncoding.DecodeString(saltBase64)
	if err != nil {
		return nil, fmt.Errorf("invalid salt: %w", err)
	}

	encryptedKey, err := base64.StdEncoding.DecodeString(encryptedKeyBase64)
	if err != nil {
		return nil, fmt.Errorf("invalid encrypted key: %w", err)
	}

	if len(encryptedKey) < 12 {
		return nil, errors.New("encrypted key too short")
	}

	nonce := encryptedKey[:12]
	ciphertext := encryptedKey[12:]

	passwordKey := argon2.IDKey(
		[]byte(password),
		salt,
		s.argon2Time,
		s.argon2Memory,
		s.argon2Threads,
		32,
	)

	block, err := aes.NewCipher(passwordKey)
	if err != nil {
		return nil, err
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	userMasterKey, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, errors.New("wrong password or corrupted key")
	}

	return userMasterKey, nil
}

func (s *CryptoService) EncryptMessage(userMessage string) (string, error) {
	encryptionKey := s.masterKey

	nonce := make([]byte, 12)
	if _, err := rand.Read(nonce); err != nil {
		return "", err
	}

	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return "", err
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	ciphertext := aesgcm.Seal(nil, nonce, []byte(userMessage), nil)
	encrypted := append(nonce, ciphertext...)

	return base64.StdEncoding.EncodeToString(encrypted), nil
}

func (s *CryptoService) DecryptMessage(encryptedText string) ([]byte, error) {
	encryptionKey := s.masterKey

	data, err := base64.StdEncoding.DecodeString(encryptedText)
	if err != nil {
		return nil, fmt.Errorf("failed to decode encrypted text: %w", err)
	}

	if len(data) < 12 {
		return nil, errors.New("encrypted data too short")
	}

	nonce := data[:12]
	ciphertext := data[12:]

	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return nil, fmt.Errorf("failed to create cipher: %w", err)
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, fmt.Errorf("failed to create GCM: %w", err)
	}

	decryptMessage, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, errors.New("decryption failed: wrong key or corrupted data")
	}

	return decryptMessage, nil
}

func (s *CryptoService) RegisterDevice(ctx context.Context, userID, deviceID, deviceName string) (string, error) {
	if deviceID == "" {
		return "", nil
	}

	deviceToken := generateDeviceToken()

	err := s.deviceRepo.CreateUserDevice(&models.CreateDeviceRequest{
		UserID:      userID,
		DeviceID:    deviceID,
		DeviceName:  deviceName,
		DeviceToken: deviceToken,
	})
	if err != nil {
		return "", fmt.Errorf("failed to register device: %w", err)
	}

	return deviceToken, nil
}

func (s *CryptoService) DeriveAndCacheKey(userID, password string, masterKey *models.UserMasterKey) ([]byte, error) {
	userMasterKey, err := s.DeriveUserKey(password, masterKey.PasswordSalt, masterKey.EncryptedPrivateKey)
	if err != nil {
		return nil, err
	}

	if s.keyCache != nil {
		if err := s.keyCache.SetMasterKey(userID, userMasterKey); err != nil {
			log.Printf("Warning: failed to cache key for user %s: %v", userID, err)
		}
	}

	return userMasterKey, nil
}

func (s *CryptoService) GetCachedKey(userID string) ([]byte, error) {
	if s.keyCache == nil {
		return nil, errors.New("key cache not available")
	}
	return s.keyCache.GetMasterKey(userID)
}

func (s *CryptoService) DeleteCachedKey(userID string) {
	if s.keyCache != nil {
		s.keyCache.DeleteMasterKey(userID)
	}
}

func generateDeviceToken() string {
	b := make([]byte, 32)
	rand.Read(b)
	return base64.URLEncoding.EncodeToString(b)
}
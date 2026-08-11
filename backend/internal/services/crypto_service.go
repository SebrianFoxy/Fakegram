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

	"fakegram-api/internal/config"
	"fakegram-api/internal/models"
)

type CryptoService struct {
	masterKey  []byte
	deviceRepo UserDeviceRepository
}

func NewCryptoService(
	cfg *config.Config,
	deviceRepo UserDeviceRepository,
) (*CryptoService, error) {
	if cfg.MasterKey == "" {
		return nil, errors.New("MASTER_KEY is not configured")
	}

	masterKey, err := hex.DecodeString(cfg.MasterKey)
	if err != nil || len(masterKey) != 32 {
		return nil, fmt.Errorf("MASTER_KEY must be 64 hex characters (32 bytes)")
	}

	return &CryptoService{
		masterKey:  masterKey,
		deviceRepo: deviceRepo,
	}, nil
}

func (s *CryptoService) EncryptMessage(plaintext string) (string, error) {
	if plaintext == "" {
		return "", nil
	}

	nonce := make([]byte, 12)
	if _, err := rand.Read(nonce); err != nil {
		return "", err
	}

	block, err := aes.NewCipher(s.masterKey)
	if err != nil {
		return "", err
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	ciphertext := aesgcm.Seal(nil, nonce, []byte(plaintext), nil)
	encrypted := append(nonce, ciphertext...)

	return base64.StdEncoding.EncodeToString(encrypted), nil
}

func (s *CryptoService) DecryptMessage(encryptedText string) (string, error) {
	if encryptedText == "" {
		return "", nil
	}

	data, err := base64.StdEncoding.DecodeString(encryptedText)
	if err != nil {
		return "", fmt.Errorf("failed to decode: %w", err)
	}

	if len(data) < 12 {
		return "", errors.New("encrypted data too short")
	}

	nonce := data[:12]
	ciphertext := data[12:]

	block, err := aes.NewCipher(s.masterKey)
	if err != nil {
		return "", err
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	plaintext, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return "", errors.New("decryption failed")
	}

	return string(plaintext), nil
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

func generateDeviceToken() string {
	b := make([]byte, 32)
	rand.Read(b)
	return base64.URLEncoding.EncodeToString(b)
}
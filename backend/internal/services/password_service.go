package services

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"fakegram-api/internal/config"
	"fmt"
	"strconv"
	"strings"

	"golang.org/x/crypto/argon2"
	"golang.org/x/crypto/bcrypt"
)

type PasswordService struct {
	time    uint32
	memory  uint32
	threads uint8
	keyLen  uint32
	saltLen uint32
}

func NewPasswordService(cfg *config.Config) *PasswordService {
	time, _ := strconv.ParseUint(cfg.Argon2Time, 10, 32)
	memory, _ := strconv.ParseUint(cfg.Argon2Memory, 10, 32)
	threads, _ := strconv.ParseUint(cfg.Argon2Threads, 10, 8)

	if time == 0 {
		time = 3
	}
	if memory == 0 {
		memory = 65536
	}
	if threads == 0 {
		threads = 4
	}

	return &PasswordService{
		time:    uint32(time),
		memory:  uint32(memory),
		threads: uint8(threads),
		keyLen:  32,
		saltLen: 16,
	}
}

func (s *PasswordService) HashPassword(password string) (string, error) {
	salt := make([]byte, s.saltLen)
	if _, err := rand.Read(salt); err != nil {
		return "", err
	}

	hash := argon2.IDKey(
		[]byte(password), salt,
		s.time, s.memory, s.threads, s.keyLen,
	)

	return fmt.Sprintf(
		"$argon2id$v=19$m=%d,t=%d,p=%d$%s$%s",
		s.memory, s.time, s.threads,
		base64.RawStdEncoding.EncodeToString(salt),
		base64.RawStdEncoding.EncodeToString(hash),
	), nil
}

func (s *PasswordService) VerifyPassword(password, hash string) bool {
	if strings.HasPrefix(hash, "$argon2id$") {
		return s.verifyArgon2(password, hash)
	}
	if strings.HasPrefix(hash, "$2a$") || strings.HasPrefix(hash, "$2b$") {
		return bcrypt.CompareHashAndPassword([]byte(hash), []byte(password)) == nil
	}
	return false
}

func (s *PasswordService) NeedsUpgrade(hash string) bool {
	return strings.HasPrefix(hash, "$2a$") || strings.HasPrefix(hash, "$2b$")
}

func (s *PasswordService) verifyArgon2(password, encoded string) bool {
	parts := strings.Split(encoded, "$")
	if len(parts) != 6 {
		return false
	}

	var mem, time uint32
	var threads uint8
	fmt.Sscanf(parts[3], "m=%d,t=%d,p=%d", &mem, &time, &threads)

	salt, _ := base64.RawStdEncoding.DecodeString(parts[4])
	expectedHash, _ := base64.RawStdEncoding.DecodeString(parts[5])

	newHash := argon2.IDKey([]byte(password), salt, time, mem, threads, uint32(len(expectedHash)))
	return subtle.ConstantTimeCompare(expectedHash, newHash) == 1
}
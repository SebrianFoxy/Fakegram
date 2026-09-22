package services

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"fakegram-api/internal/config"
	"fmt"
	"log"
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
		log.Printf("Invalid format: expected 6 parts, got %d", len(parts))
		return false
	}

	if parts[2] != "v=19" {
		log.Printf("Unsupported argon2 version: %s", parts[2])
		return false
	}

	params := strings.Split(parts[3], ",")
	
	var memory uint32
	var time uint32
	var threads uint8

	for _, param := range params {
		kv := strings.Split(param, "=")
		if len(kv) != 2 {
			log.Printf("Invalid parameter format: %s", param)
			continue
		}
		
		switch kv[0] {
		case "m":
			val, err := strconv.ParseUint(kv[1], 10, 32)
			if err != nil {
				log.Printf("Failed to parse memory: %v", err)
				return false
			}
			memory = uint32(val)
		case "t":
			val, err := strconv.ParseUint(kv[1], 10, 32)
			if err != nil {
				log.Printf("Failed to parse time: %v", err)
				return false
			}
			time = uint32(val)
		case "p":
			val, err := strconv.ParseUint(kv[1], 10, 8)
			if err != nil {
				log.Printf("Failed to parse threads: %v", err)
				return false
			}
			threads = uint8(val)
		}
	}

	if memory == 0 || time == 0 || threads == 0 {
		log.Printf("Missing argon2 parameters: m=%d, t=%d, p=%d", memory, time, threads)
		return false
	}

	salt, err := base64.RawStdEncoding.DecodeString(parts[4])
	if err != nil {
		log.Printf("Salt decode error: %v", err)
		return false
	}

	expectedHash, err := base64.RawStdEncoding.DecodeString(parts[5])
	if err != nil {
		log.Printf("Hash decode error: %v", err)
		return false
	}

	newHash := argon2.IDKey([]byte(password), salt, time, memory, threads, uint32(len(expectedHash)))
	
	result := subtle.ConstantTimeCompare(expectedHash, newHash) == 1

	return result
}
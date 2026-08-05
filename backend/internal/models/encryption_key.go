package models

import (
	"time"
)

type UserMasterKey struct {
	ID                  string 	  `json:"id"`
	UserID              string 	  `json:"user_id"`
	EncryptedPrivateKey string    `json:"encrypted_private_key"`
	PasswordSalt        string    `json:"password_salt"`
	PublicKey           string    `json:"public_key"`
	KeyVersion          int       `json:"key_version"`
	CreatedAt           time.Time `json:"created_at"`
	UpdatedAt           time.Time `json:"updated_at"`
}

type CreateUserMasterKeyRequest struct {
	UserID              string	  `json:"user_id" validate:"required"`
	EncryptedPrivateKey string    `json:"encrypted_private_key" validate:"required"`
	PasswordSalt        string    `json:"password_salt" validate:"required"`
	PublicKey           string    `json:"public_key" validate:"required"`
}

type UpdateUserMasterKeyRequest struct {
	EncryptedPrivateKey string `json:"encrypted_private_key" validate:"required"`
}
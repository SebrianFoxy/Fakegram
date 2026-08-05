package repositories

import (
	"database/sql"
	"fakegram-api/internal/models"
	"fmt"
)

type EncryptionKeyRepository struct {
	db *sql.DB
}

func NewEncryptionKeyRepository(db *sql.DB) *EncryptionKeyRepository {
	return &EncryptionKeyRepository{db: db}
}

func (r *EncryptionKeyRepository) CreateEncryptionKey(req *models.CreateUserMasterKeyRequest) error {
	query := `
		INSERT INTO user_master_keys (user_id, encrypted_private_key, password_salt, public_key)
		VALUES ($1, $2, $3, $4)
	`

	_, err := r.db.Exec(query, req.UserID, req.EncryptedPrivateKey, req.PasswordSalt, req.PublicKey)
	if err != nil {
		return fmt.Errorf("failed to create master key: %w", err)
	}

	return nil
}

func (r *EncryptionKeyRepository) GetByUserID(userID string) (*models.UserMasterKey, error) {
	query := `
		SELECT id, user_id, encrypted_private_key, password_salt, 
			public_key, key_version, created_at, updated_at
		FROM user_master_keys
		WHERE user_id = $1
	`

	key := &models.UserMasterKey{}
	err := r.db.QueryRow(query, userID).Scan(
		&key.ID, &key.UserID, &key.EncryptedPrivateKey,
		&key.PasswordSalt, &key.PublicKey, &key.KeyVersion,
		&key.CreatedAt, &key.UpdatedAt,
	)

	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get master key: %w", err)
	}

	return key, nil
}

func (r *EncryptionKeyRepository) UpdateEncryptionKey(userID string, encryptedKey string) error {
	query := `
		UPDATE user_master_keys 
		SET encrypted_private_key = $1, updated_at = CURRENT_TIMESTAMP
		WHERE user_id = $2
	`

	result, err := r.db.Exec(query, encryptedKey, userID)
	if err != nil {
		return fmt.Errorf("failed to update master key: %w", err)
	}

	rows, _ := result.RowsAffected()
	if rows == 0 {
		return fmt.Errorf("master key not found for user %s", userID)
	}

	return nil
}

func (r *EncryptionKeyRepository) DeleteEncryptionKey(userID string) error {
	query := `DELETE FROM user_master_keys WHERE user_id = $1`

	_, err := r.db.Exec(query, userID)
	if err != nil {
		return fmt.Errorf("failed to delete master key: %w", err)
	}

	return nil
}
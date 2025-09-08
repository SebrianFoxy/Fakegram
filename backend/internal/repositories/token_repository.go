package repositories

import (
	"context"
	"database/sql"
	"errors"
	"fmt"

	"fakegram-api/internal/models"
)

var ErrTokenNotFound = errors.New("token not found")

type TokenRepository struct {
	DB *sql.DB
}

func NewTokenRepository(db *sql.DB) *TokenRepository {
	return &TokenRepository{DB: db}
}

func (r *TokenRepository) CreateToken(ctx context.Context, token *models.LoginToken) error {
	query := `
		INSERT INTO login_tokens (id, token, refresh_token, user_id, created_at, expired_at, refresh_token_expired_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`
	_, err := r.DB.ExecContext(ctx, query,
		token.ID,
		token.Token,
		token.RefreshToken,
		token.UserID,
		token.CreatedAt,
		token.ExpiredAt,
		token.RefreshTokenExpiredAt,
	)
	if err != nil {
		return fmt.Errorf("failed to insert token: %w", err)
	}
	return nil
}
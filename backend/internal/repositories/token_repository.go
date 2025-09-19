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
		INSERT INTO login_tokens (id, access_token, refresh_token, user_id, created_at, expired_at, refresh_token_expired_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`
	_, err := r.DB.ExecContext(ctx, query,
		token.ID,
		token.AccessToken,
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

func (r *TokenRepository) FindValidTokenByAccessToken(ctx context.Context, accessToken string) (*models.LoginToken, error) {
	query := `
		SELECT id, access_token, refresh_token, user_id, created_at, expired_at, refresh_token_expired_at
		FROM login_tokens 
		WHERE access_token = $1 AND expired_at > NOW()
	`
	
	token := &models.LoginToken{}
	err := r.DB.QueryRowContext(ctx, query, accessToken).Scan(
		&token.ID,
		&token.AccessToken,
		&token.RefreshToken,
		&token.UserID,
		&token.CreatedAt,
		&token.ExpiredAt,
		&token.RefreshTokenExpiredAt,
	)
	
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, ErrTokenNotFound
		}
		return nil, fmt.Errorf("failed to find token: %w", err)
	}
	
	return token, nil
}

func (r *TokenRepository) GetByRefreshToken(ctx context.Context, refreshToken string) (*models.LoginToken, error) {
	var token models.LoginToken
	query := `SELECT id, access_token, refresh_token, user_id, created_at, expired_at, refresh_token_expired_at 
			  FROM login_tokens WHERE refresh_token = $1`
	
	row := r.DB.QueryRowContext(ctx, query, refreshToken)
	err := row.Scan(
		&token.ID,
		&token.AccessToken,
		&token.RefreshToken,
		&token.UserID,
		&token.CreatedAt,
		&token.ExpiredAt,
		&token.RefreshTokenExpiredAt,
	)
	
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("token not found")
		}
		return nil, err
	}
	
	return &token, nil
}

func (r *TokenRepository) UpdateToken(ctx context.Context, token *models.LoginToken) error {
	query := `UPDATE login_tokens 
			SET access_token = $1, refresh_token = $2, expired_at = $3, refresh_token_expired_at = $4 
			WHERE id = $5`
	_, err := r.DB.ExecContext(ctx, query,
		token.AccessToken,
		token.RefreshToken,
		token.ExpiredAt,
		token.RefreshTokenExpiredAt,
		token.ID)
	return err
}


package models

import (
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LoginToken struct {
	ID        				string    	`json:"id"`
	AccessToken     		string 		`db:"access_token"`
	RefreshToken 			string 		`json:"refresh_token"`
	UserID    				string 		`json:"user_id"`
	CreatedAt				time.Time	`json:"created_at"`
	ExpiredAt 				time.Time 	`json:"expired_at"`
	RefreshTokenExpiredAt	time.Time	`json:"refresh_token_expired_at"`
}

type TokenResponse struct {
	AccessToken  string `json:"access_token"`
	RefreshToken string `json:"refresh_token"`
	TokenType    string `json:"token_type"`
	ExpiresIn    int64  `json:"expires_in"`
}

type RefreshRequest struct {
	RefreshToken	string `json:"refresh_token" validate:"required"`
	RefreshRotate	bool   `json:"refresh_rotate"`
}

type Claims struct {
	UserID string `json:"user_id"`
	jwt.RegisteredClaims
}
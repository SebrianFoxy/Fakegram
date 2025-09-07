package models

import "time"

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LoginToken struct {
	ID        				string    	`json:"id"`
	Token     				string 		`db:"token"`
	RefreshToken 			string 		`json:"refresh_token"`
	UserID    				string 		`json:"user_id"`
	CreatedAt				time.Time	`json:"created_at"`
	ExpiredAt 				time.Time 	`json:"expired_at"`
	RefreshTokenExpiredAt	time.Time	`json:"refresh_token_expired_at"`
}
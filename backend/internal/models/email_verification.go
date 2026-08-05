package models

type EmailVerificationToken struct {
	UserID    string `json:"user_id"`
	Email     string `json:"email"`
	Type      string `json:"type"`
	ExpiresAt int64  `json:"expires_at"`
}
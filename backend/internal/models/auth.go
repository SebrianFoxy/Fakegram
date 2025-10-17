package models

import (
	"regexp"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
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

type RegistrationRequest struct {
    Name     string `json:"name" validate:"required"`
    Surname  string `json:"surname" validate:"required"`
	Nickname string `json:"nickname" validate:"required"`
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required,min=6"`
}

func NewUserFromRequest(req *RegistrationRequest) *User {
    user := &User{
		Name:      strings.TrimSpace(req.Name),
		Surname:   strings.TrimSpace(req.Surname),
		Nickname:  strings.TrimSpace(req.Nickname),
		Email:     req.Email,
		Password:  req.Password,
		Approved:  false,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

    user.NormalizeEmail()
	
	return user
}

func (u *User) HashPassword() error {
    hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
    if err != nil {
        return err
    }
    u.Password = string(hashedPassword)
    return nil
}

func (u *User) CheckPassword(password string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
    return err == nil
}

func (u *User) NormalizeEmail() {
    u.Email = strings.ToLower(strings.TrimSpace(u.Email))
}

func (u *User) IsEmailValid() bool {
	email := u.Email
	if email == "" || utf8.RuneCountInString(email) > 254 {
		return false
	}
	
	emailRegex := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
	return emailRegex.MatchString(email)
}

func NormalizeNickname(nickname string) string {
    return strings.ToLower(strings.TrimSpace(nickname))
}

func (u *User) CheckNickname(nickname string) bool {
	print("\nNICKNAME ", nickname,)
	print("\nU.NICKNAME ", u.Nickname, "\n")
    return NormalizeNickname(nickname) == NormalizeNickname(u.Nickname)
}

package services

import (
	"fakegram-api/internal/models"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

type TokenService struct {
	jwtKey []byte
}

func NewTokenService(jwtKey []byte) *TokenService {
	return &TokenService{jwtKey: jwtKey}
}

func (s *TokenService) GenerateTokens(userID string) (*models.LoginToken, error) {
	accessToken, err := s.generateAccessToken(userID)
	if err != nil {
		return nil, err
	}

	refreshToken := uuid.New().String()
	expiration := time.Now().Add(15 * time.Minute)
	refreshExpiration := time.Now().Add(7 * 24 * time.Hour)

	return &models.LoginToken{
		ID:                    uuid.New().String(),
		AccessToken:           accessToken,
		RefreshToken:          refreshToken,
		UserID:                userID,
		CreatedAt:             time.Now(),
		ExpiredAt:             expiration,
		RefreshTokenExpiredAt: refreshExpiration,
	}, nil
}

func (s *TokenService) RefreshTokens(existingToken *models.LoginToken, refreshRotate bool) (*models.LoginToken, error) {
	if refreshRotate {
		return s.generateTokenPair(existingToken.UserID, true)
	} else {
		return s.refreshAccessTokenOnly(existingToken)
	}
}

func (s *TokenService) generateTokenPair(userID string, includeRefresh bool) (*models.LoginToken, error) {
	accessToken, err := s.generateAccessToken(userID)
	if err != nil {
		return nil, err
	}

	var refreshToken string
	if includeRefresh {
		refreshToken = uuid.New().String()
	}

	expiration := time.Now().Add(15 * time.Minute)
	refreshExpiration := time.Now().Add(7 * 24 * time.Hour)

	return &models.LoginToken{
		ID:                    uuid.New().String(),
		AccessToken:           accessToken,
		RefreshToken:          refreshToken,
		UserID:                userID,
		CreatedAt:             time.Now(),
		ExpiredAt:             expiration,
		RefreshTokenExpiredAt: refreshExpiration,
	}, nil
}

func (s *TokenService) generateAccessToken(userID string) (string, error) {
	expiration := time.Now().Add(15 * time.Minute)
	claims := jwt.RegisteredClaims{
		Subject:   userID,
		ExpiresAt: jwt.NewNumericDate(expiration),
		IssuedAt:  jwt.NewNumericDate(time.Now()),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(s.jwtKey)
}

func (s *TokenService) refreshAccessTokenOnly(existingToken *models.LoginToken) (*models.LoginToken, error) {
	accessToken, err := s.generateAccessToken(existingToken.UserID)
	if err != nil {
		return nil, err
	}

	existingToken.AccessToken = accessToken
	existingToken.ExpiredAt = time.Now().Add(15 * time.Minute)

	return existingToken, nil
}


func (s *TokenService) ValidateAccessToken(tokenString string) (*jwt.RegisteredClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &jwt.RegisteredClaims{}, func(token *jwt.Token) (interface{}, error) {
		return s.jwtKey, nil
	})

	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*jwt.RegisteredClaims); ok && token.Valid {
		return claims, nil
	}

	return nil, jwt.ErrSignatureInvalid
}

func (s *TokenService) GetTokenResponse(loginToken *models.LoginToken) *models.TokenResponse {
	return &models.TokenResponse{
		AccessToken:  loginToken.AccessToken,
		RefreshToken: loginToken.RefreshToken,
		TokenType:    "Bearer",
		ExpiresIn:    int64(15 * time.Minute / time.Second),
	}
}
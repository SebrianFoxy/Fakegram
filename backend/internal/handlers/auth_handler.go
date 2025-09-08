package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"log"
	"net/http"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type AuthHandler struct {
	userRepo *repositories.UserRepository
	tokenRepo *repositories.TokenRepository
	jwtKey []byte
}

func NewAuthHandler(userRepo *repositories.UserRepository, tokenRepo *repositories.TokenRepository, jwtKey []byte) *AuthHandler {
	return &AuthHandler{
		userRepo:	 userRepo,
		tokenRepo:	 tokenRepo,
		jwtKey:		 jwtKey,
	}
}

// LoginUser проверяет email и пароль
// @Summary		Авторизация пользователя
// @Description	Проверяет email и пароль
// @Tags		auth
// @Accept		json
// @Produce		json
// @Param		request body models.LoginRequest true "Данные для авторизации"
// @Success		200 {object} map[string]string "Успешная авторизация"
// @Failure		400 {object} map[string]string "Неверный формат запроса"
// @Failure		401 {object} map[string]string "Неверный email или пароль"
// @Failure 	500 {object} map[string]string "Ошибка сервера"
// @Router		/api/v1/auth/login [post]
func (h *AuthHandler) LoginUser(c echo.Context) error {
	var req models.LoginRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request payload"})
	}

	ctx := c.Request().Context()
	user, err := h.userRepo.GetByEmail(ctx, req.Email)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid email or password"})
	}

	if !user.CheckPassword(req.Password){
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid email or password"})
	}

	expiration := time.Now().Add(15 * time.Minute)
	claims := jwt.MapClaims{
		"user_id": 	user.ID,
		"exp":		expiration.Unix(),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims);
	jwtToken, err := token.SignedString(h.jwtKey)
	if err != nil {
		log.Println("JWT generation error:", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
	}

	refreshToken := uuid.New().String()
	refreshExpiration := time.Now().Add(7 * 24 * time.Hour)

	loginToken := &models.LoginToken{
		ID:						uuid.New().String(),
		Token:					jwtToken,
		RefreshToken:			refreshToken,
		UserID:					user.ID,
		CreatedAt: 				time.Now(),
		ExpiredAt:				expiration,
		RefreshTokenExpiredAt: 	refreshExpiration,
	}

	if err := h.tokenRepo.CreateToken(ctx, loginToken); err != nil {
		log.Println("JWT save error:", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to save token"})
	}

	return c.JSON(http.StatusOK, map[string]string{"token": jwtToken, "refresh_token": refreshToken})
}
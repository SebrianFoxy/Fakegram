package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/services"
	"log"
	"net/http"
	"time"

	"github.com/labstack/echo/v4"
)

type AuthHandler struct {
	userRepo *repositories.UserRepository
	tokenRepo *repositories.TokenRepository
	tokenService *services.TokenService
}

func NewAuthHandler(
	userRepo *repositories.UserRepository, 
	tokenRepo *repositories.TokenRepository, 
	tokenService *services.TokenService,
	) *AuthHandler {
	return &AuthHandler{
		userRepo:	 userRepo,
		tokenRepo:	 tokenRepo,
		tokenService: tokenService,
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

	loginToken, err := h.tokenService.GenerateTokens(user.ID)
	if err != nil {
		log.Println("Token generation error:", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
	}

	if err := h.tokenRepo.CreateToken(ctx, loginToken); err != nil {
		log.Println("JWT save error:", err)
		return c.JSON(http.StatusInternalServerError, 
			map[string]string{"error": "Failed to save token"})
	}

	return c.JSON(http.StatusOK, h.tokenService.GetTokenResponse(loginToken))
}

// RefreshToken обновляет access токен с помощью refresh токена
// @Summary		Обновление токенов
// @Description	Обновляет access токен или оба токена с помощью refresh токена
// @Tags		auth
// @Accept		json
// @Produce		json
// @Param		request body models.RefreshRequest true "Данные для обновления токенов"
// @Success		200 {object} models.TokenResponse "Успешное обновление токенов"
// @Failure		400 {object} map[string]string "Неверный формат запроса"
// @Failure		401 {object} map[string]string "Невалидный или просроченный refresh token"
// @Failure 	500 {object} map[string]string "Ошибка сервера"
// @Router		/api/v1/auth/refresh [post]
func (h *AuthHandler) RefreshToken(c echo.Context) error {
	var req models.RefreshRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request payload"})
	}

	ctx := c.Request().Context()

	loginToken, err := h.tokenRepo.GetByRefreshToken(ctx, req.RefreshToken)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid refresh token"})
	}

	if time.Now().After(loginToken.RefreshTokenExpiredAt) {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Refresh token expired"})
	}
	
	_, err = h.userRepo.GetUserByID(ctx, loginToken.UserID)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "User not found"})
	}

	var updatedToken *models.LoginToken

	if req.RefreshRotate {
		updatedToken, err = h.tokenService.GenerateTokens(loginToken.UserID)
		if err != nil {
			log.Println("Token generation error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate tokens"})
		}
	} else {
		updatedToken, err = h.tokenService.RefreshTokens(loginToken, req.RefreshRotate)
		if err != nil {
			log.Println("Token generation error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
		}
	}

	if req.RefreshRotate {
		if err := h.tokenRepo.CreateToken(ctx, updatedToken); err != nil {
			log.Println("Token create error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to create token"})
		}
		
		// if err := h.tokenRepo.DeleteByID(ctx, loginToken.ID); err != nil {
		// 	log.Println("Warning: failed to delete old token:", err)
		// }
	} else {
		if err := h.tokenRepo.UpdateToken(ctx, updatedToken); err != nil {
			log.Println("Token update error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to update token"})
		}
	}

	return c.JSON(http.StatusOK, h.tokenService.GetTokenResponse(updatedToken))
}
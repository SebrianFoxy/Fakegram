package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"net/http"

	"github.com/labstack/echo/v4"
)

type AuthHandler struct {
	userRepo *repositories.UserRepository
}

func NewAuthHandler(userRepo *repositories.UserRepository) *AuthHandler {
	return &AuthHandler{userRepo: userRepo}
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

	return c.JSON(http.StatusOK, map[string]string{"message": "Login successful"})
}
package handlers

import (
	"errors"
	"fakegram-api/internal/models"
	"fakegram-api/internal/services"
	"log"
	"net/http"
	"time"

	"github.com/labstack/echo/v4"
)

type AuthHandler struct {
	userService UserService
	tokenService TokenService
	emailVerificationService EmailVerificationService
	cryptoService CryptoService
}

func NewAuthHandler(
	userService UserService, 
	tokenService TokenService,
	emailVerificationService EmailVerificationService,
	cryptoService CryptoService,
	) *AuthHandler {
	return &AuthHandler{
		userService: userService,
		tokenService: tokenService,
		emailVerificationService: emailVerificationService,
		cryptoService: cryptoService,
	}
}

// LoginUser 	Проверяет email и пароль
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
	user, err := h.userService.GetByEmail(ctx, req.Email)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid email or password"})
	}

	if !user.CheckPassword(req.Password){
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid email or password"})
	}

	if !user.Approved {
		if err := h.emailVerificationService.SendVerificationEmail(user.Email, user.ID); err != nil {
			log.Printf("Failed to resend verification email to %s: %v", user.Email, err)
		}
		
		return c.JSON(http.StatusForbidden, map[string]string{
			"error": "Account not confirmed. Confirmation email has been resent.",
		})
	}

	masterKey, err := h.cryptoService.GetOrCreateUserKey(ctx, user.ID, req.Password)
	if err != nil {
		log.Printf("Failed to get/create encryption key: %v", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to initialize encryption"})
	}

	_, err = h.cryptoService.DeriveAndCacheKey(user.ID, req.Password, masterKey)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid credentials"})
	}

	// deviceToken, err := h.cryptoService.RegisterDevice(ctx, user.ID, req.DeviceID, req.DeviceName)
	// if err != nil {
	// 	log.Printf("Warning: failed to register device: %v", err)
	// }

	loginToken, err := h.tokenService.GenerateTokens(user.ID)
	if err != nil {
		log.Println("Token generation error:", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to generate token"})
	}

	if err := h.tokenService.CreateToken(ctx, loginToken); err != nil {
		log.Println("JWT save error:", err)
		return c.JSON(http.StatusInternalServerError, 
			map[string]string{"error": "Failed to save token"})
	}

	response := map[string]interface{}{
		"token":   h.tokenService.GetTokenResponse(loginToken),
		"user": user.ToResponse(),
	}

	return c.JSON(http.StatusOK, response)
}

// RegistrationUser Регистрация нового пользователя
// @Summary      Регистрация
// @Description  Регистрирует нового пользователя в системе
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        request body models.RegistrationRequest true "Данные пользователя"
// @Success      201 {object} models.UserResponse "Пользователь создан"
// @Failure      400 {object} map[string]string "Неверный формат данных"
// @Failure      409 {object} map[string]string "Email уже существует"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Router       /api/v1/auth/registration [post]
func (h *AuthHandler) RegistrationUser(c echo.Context) error {
    var req models.RegistrationRequest

	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request payload"})
	}

	ctx := c.Request().Context()

	user, err := h.userService.CreateUser(ctx, &req)
	if err != nil {
		switch {
		case err.Error() == "invalid email format":
			return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid email format"})
		case errors.Is(err, services.ErrNicknameExists):
			return c.JSON(http.StatusConflict, map[string]string{"error": "Nickname already exists"})
		case errors.Is(err, services.ErrEmailExists):
			return c.JSON(http.StatusConflict, map[string]string{"error": "Email already exists"})
		default:
			var emailErr *services.EmailNotConfirmedError
			if errors.As(err, &emailErr) {
				if err := h.emailVerificationService.SendVerificationEmail(emailErr.Email, emailErr.UserID); err != nil {
					return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to send confirmation email"})
				}

				return c.JSON(http.StatusConflict, map[string]string{
					"error": "Email already exists but not confirmed. Confirmation email has been resent.",
				})
			}

			log.Printf("Registration error: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to create user"})
		}
	}
	
	if err := h.cryptoService.InitUserKeys(ctx, user.ID, req.Password); err != nil {
		log.Printf("Failed to create encryption keys for user %s: %v", user.ID, err)
	}

	if err := h.emailVerificationService.SendVerificationEmail(user.Email, user.ID); err != nil {
		log.Printf("Failed to send verification email to %s: %v", user.Email, err)

		return c.JSON(http.StatusCreated, map[string]interface{}{
			"user":    user.ToResponse(),
			"warning": "User created but verification email failed to send",
		})
	}

	return c.JSON(http.StatusCreated, user.ToResponse())
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

	loginToken, err := h.tokenService.GetByRefreshToken(ctx, req.RefreshToken)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Invalid refresh token"})
	}

	if time.Now().After(loginToken.RefreshTokenExpiredAt) {
		h.cryptoService.DeleteCachedKey(loginToken.UserID)
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Refresh token expired"})
	}

	if time.Now().After(loginToken.RefreshTokenExpiredAt) {
		return c.JSON(http.StatusUnauthorized, map[string]string{"error": "Refresh token expired"})
	}
	
	_, err = h.userService.GetUserByID(ctx, loginToken.UserID)
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
		if err := h.tokenService.CreateToken(ctx, updatedToken); err != nil {
			log.Println("Token create error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to create token"})
		}
	} else {
		if err := h.tokenService.UpdateToken(ctx, updatedToken); err != nil {
			log.Println("Token update error:", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to update token"})
		}
	}

	response := map[string]interface{}{
		"token":   h.tokenService.GetTokenResponse(updatedToken),
	}

	return c.JSON(http.StatusOK, response)
}

func (h *AuthHandler) VerifyEmail(c echo.Context) error {
    token := c.QueryParam("token")
    if token == "" {
        html, err := h.emailVerificationService.RenderVerificationError()
        if err != nil {
            return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Template error"})
        }
        return c.HTML(http.StatusOK, html)
    }

    tokenData, err := h.emailVerificationService.VerifyToken(token)
    if err != nil {
        html, err := h.emailVerificationService.RenderVerificationError()
        if err != nil {
            return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Template error"})
        }
        return c.HTML(http.StatusOK, html)
    }

    if tokenData.Type != "verification" {
        html, err := h.emailVerificationService.RenderVerificationError()
        if err != nil {
            return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Template error"})
        }
        return c.HTML(http.StatusOK, html)
    }

    userID := tokenData.UserID
    if err := h.userService.MarkEmailAsVerified(c.Request().Context(), userID); err != nil {
        html, err := h.emailVerificationService.RenderVerificationError()
        if err != nil {
            return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Template error"})
        }
        return c.HTML(http.StatusOK, html)
    }

    html, err := h.emailVerificationService.RenderVerificationSuccess()
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Template error"})
    }
    return c.HTML(http.StatusOK, html)
}
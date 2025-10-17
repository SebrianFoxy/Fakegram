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
	emailVerificationService *services.EmailVerificationService
}

func NewAuthHandler(
	userRepo *repositories.UserRepository, 
	tokenRepo *repositories.TokenRepository, 
	tokenService *services.TokenService,
	emailVerificationService *services.EmailVerificationService,
	) *AuthHandler {
	return &AuthHandler{
		userRepo:	 userRepo,
		tokenRepo:	 tokenRepo,
		tokenService: tokenService,
		emailVerificationService: emailVerificationService,
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
	user, err := h.userRepo.GetByEmail(ctx, req.Email)
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

    user := models.NewUserFromRequest(&req)

	if !user.IsEmailValid() {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid email format"})
	}

    if err := user.HashPassword(); err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to process password"})
    }

	ctx := c.Request().Context()

	existingUserByNickname, err := h.userRepo.GetByNickname(ctx, user.Nickname)
    if err != nil && err != repositories.ErrNotFound {
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to check nickname availability"})
    }

    if existingUserByNickname != nil {
		return c.JSON(http.StatusConflict, map[string]string{"error": "Nickname already exists"})
	}

    if err := h.userRepo.CreateUser(ctx, user); err != nil {
        if err == repositories.ErrEmailExists {
            existingUser, err := h.userRepo.GetByEmail(ctx, user.Email)
			if err != nil {
				return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to check user status"})
			}

			if existingUser != nil && !existingUser.Approved {

				if err := h.emailVerificationService.SendVerificationEmail(user.Email, user.ID); err != nil {
					return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to send confirmation email"})
				}
				
				return c.JSON(http.StatusConflict, map[string]string{
					"error": "Email already exists but not confirmed. Confirmation email has been resent.",
				})
			}
			return c.JSON(http.StatusConflict, map[string]string{"error": "Email already exists"})
        }
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to create user"})
    }

    if err := h.emailVerificationService.SendVerificationEmail(user.Email, user.ID); err != nil {

        log.Printf("Failed to send verification email to %s: %v", user.Email, err)

        return c.JSON(http.StatusCreated, map[string]interface{}{
            "user": user.ToResponse(),
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
    if err := h.userRepo.MarkEmailAsVerified(c.Request().Context(), userID); err != nil {
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
package handlers

import (
	"fakegram-api/internal/services"
	"net/http"
	"strconv"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type UserHandler struct {
    userService UserService
}

func NewUserHandler(userService UserService) *UserHandler {
    return &UserHandler{
        userService: userService,
    }
}

// GetAllUsers возвращает список пользователей с пагинацией
// @Summary      Получить пользователей
// @Description  Возвращает список пользователей с поддержкой пагинации
// @Tags         users
// @Accept       json
// @Produce      json
// @Param        page  query int false "Номер страницы" default(1) minimum(1)
// @Param        limit query int false "Количество записей на странице" default(10) minimum(1) maximum(100)
// @Success      200 {object} map[string]interface{} "Список пользователей"
// @Security     BearerAuth
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Router       /api/v1/users/all_users [get]
func (h *UserHandler) GetAllUsers(c echo.Context) error {
    ctx := c.Request().Context()

    page, _ := strconv.Atoi(c.QueryParam("page"))
	limit, _ := strconv.Atoi(c.QueryParam("limit"))

    result, err := h.userService.GetAllUsers(ctx, page, limit)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to get users",
		})
	}

	totalPages := (result.TotalCount + limit - 1) / limit
	if limit == 0 {
		limit = 10 
	}
	if page == 0 {
		page = 1
	}

	response := map[string]interface{}{
		"users": result.Users,
		"pagination": map[string]interface{}{
			"page":        page,
			"limit":       limit,
			"total_count": result.TotalCount,
			"total_pages": totalPages,
			"has_next":    page*limit < result.TotalCount,
			"has_prev":    page > 1,
		},
	}

	return c.JSON(http.StatusOK, response)
}

// GetUser возвращает информацию о текущем авторизованном пользователе
// @Summary      Получить текущего пользователя
// @Description  Возвращает информацию о пользователе на основе JWT токена
// @Tags         users
// @Accept       json
// @Produce      json
// @Success      200 {object} models.UserResponse "Информация о пользователе"
// @Failure      401 {object} map[string]string "Неавторизован"
// @Failure      404 {object} map[string]string "Пользователь не найден"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/users [get]
func (h *UserHandler) GetUser(c echo.Context) error {
    token, ok := c.Get("user").(*jwt.Token)
    if !ok {
        return c.JSON(http.StatusUnauthorized, map[string]string{
            "error": "Invalid token",
        })
    }

    claims, ok := token.Claims.(*jwt.RegisteredClaims)
    if !ok {
        return c.JSON(http.StatusUnauthorized, map[string]string{
            "error": "Invalid token claims",
        })
    }

    userID := claims.Subject
    if userID == "" {
        return c.JSON(http.StatusUnauthorized, map[string]string{
            "error": "User ID not found in token",
        })
    }

    ctx := c.Request().Context()
    user, err := h.userService.GetUserByID(ctx, userID)
    if err != nil {
        if err == services.ErrNotFound {
            return c.JSON(http.StatusNotFound, map[string]string{
                "error": "User not found",
            })
        }
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Failed to get user",
        })
    }
    
    return c.JSON(http.StatusOK, user.ToResponse())
}
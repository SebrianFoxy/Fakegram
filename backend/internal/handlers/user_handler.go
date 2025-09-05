package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
)

type UserHandler struct {
    userRepo *repositories.UserRepository
}

func NewUserHandler(userRepo *repositories.UserRepository) *UserHandler {
    return &UserHandler{userRepo: userRepo}
}

// CreateUser создает нового пользователя
// @Summary      Создать пользователя
// @Description  Регистрирует нового пользователя в системе
// @Tags         users
// @Accept       json
// @Produce      json
// @Param        request body models.CreateUserRequest true "Данные пользователя"
// @Success      201 {object} models.UserResponse "Пользователь создан"
// @Failure      400 {object} map[string]string "Неверный формат данных"
// @Failure      409 {object} map[string]string "Email уже существует"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Router       /api/v1/users [post]
func (h *UserHandler) CreateUser(c echo.Context) error {
    var req models.CreateUserRequest
    
    if err := c.Bind(&req); err != nil {
        return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request payload"})
    }

    user := models.User{
        Name:     req.Name,
        Email:    req.Email,
        Password: req.Password,
    }

    if err := user.HashPassword(); err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to process password"})
    }

    ctx := c.Request().Context()
    if err := h.userRepo.CreateUser(ctx, &user); err != nil {
        if err == repositories.ErrEmailExists {
            return c.JSON(http.StatusConflict, map[string]string{"error": "Email already exists"})
        }
        return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to create user"})
    }

    return c.JSON(http.StatusCreated, user.ToResponse())
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
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Router       /api/v1/users [get]
func (h *UserHandler) GetAllUsers(c echo.Context) error {
    ctx := c.Request().Context()

    page, _ := strconv.Atoi(c.QueryParam("page"))
    if page < 1 {
        page = 1
    }

    limit, _ := strconv.Atoi(c.QueryParam("limit"))
    if limit < 1 || limit > 100 {
        limit = 10
    }

    users, totalCount, err := h.userRepo.GetAllUsers(ctx, page, limit)
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]string{
            "error": "Failed to get users",
        })
    }

    usersResponse := make([]models.UserResponse, len(users))
    for i, user := range users {
        usersResponse[i] = user.ToResponse()
    }

    response := map[string]interface{}{
        "users": usersResponse,
        "pagination": map[string]interface{}{
            "page":        page,
            "limit":       limit,
            "total_count": totalCount,
            "total_pages": (totalCount + limit - 1) / limit, // ceil division
            "has_next":    page*limit < totalCount,
            "has_prev":    page > 1,
        },
    }

    return c.JSON(http.StatusOK, response)
}
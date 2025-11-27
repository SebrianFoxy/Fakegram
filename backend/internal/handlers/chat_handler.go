package handlers

import (
	"fakegram-api/internal/repositories"
	"net/http"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type ChatHandler struct {
    chatRepo *repositories.ChatRepository
}

func NewChatHandler(chatRepo *repositories.ChatRepository) *ChatHandler {
    return &ChatHandler{
        chatRepo: chatRepo,
    }
}

// GetUserChats возвращает информацию о чатах пользователя
// @Summary      Получить чаты пользователя
// @Description  Возвращает список всех чатов (приватных и групповых) пользователя на основе JWT токена. Для приватных чатов автоматически устанавливается название в формате "Имя Фамилия" собеседника.
// @Tags         chats
// @Accept       json
// @Produce      json
// @Success      200 {object} map[string]interface{} "Список чатов пользователя"
// @Success      200 {object} map[string]interface{} "chats": "Список объектов ChatListItem", "count": "Количество чатов"
// @Failure      401 {object} map[string]string "Неавторизован - невалидный токен или claims"
// @Failure      500 {object} map[string]string "Внутренняя ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/chats [get]
func (h *ChatHandler) GetUserChats(c echo.Context) error {
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

	chats, err := h.chatRepo.GetUserChats(ctx, userID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to get user chats: " + err.Error(),
		})
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"chats": chats,
		"count": len(chats),
	})
}
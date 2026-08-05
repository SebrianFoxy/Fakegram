package handlers

import (
	"fakegram-api/internal/models"
	"net/http"
	"strconv"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type ChatHandler struct {
    chatService ChatService
}

func NewChatHandler(chatService ChatService) *ChatHandler {
    return &ChatHandler{
        chatService: chatService,
    }
}

// GetUserChats  возвращает информацию о чатах пользователя
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

	chats, err := h.chatService.GetUserChats(ctx, userID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to get user chats: " + err.Error(),
		})
	}

	if chats == nil {
		chats = make([]*models.ChatListItem, 0)
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"chats": chats,
		"count": len(chats),
	})
}

// SearchChats - поиск чатов (пользователей и групп)
// @Summary      Поиск чатов
// @Description  Поиск пользователей и групп по никнейму или названию
// @Tags         chats
// @Accept       json
// @Produce      json
// @Param        query    query    string  true   "Поисковый запрос"
// @Param        limit    query    int     false  "Лимит результатов (по умолчанию 20, максимум 100)"
// @Param        offset   query    int     false  "Смещение для пагинации"
// @Success      200 {object} map[string]interface{} "Результаты поиска"
// @Failure      400 {object} map[string]string "Неверные параметры запроса"
// @Failure      401 {object} map[string]string "Неавторизован"
// @Failure      500 {object} map[string]string "Внутренняя ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/chats/search [get]
func (h *ChatHandler) SearchChats(c echo.Context) error {
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

	query := c.QueryParam("query")
	if query == "" {
		return c.JSON(http.StatusBadRequest, map[string]string{
			"error": "Search query is required",
		})
	}

	limit := 20
	if limitStr := c.QueryParam("limit"); limitStr != "" {
		if l, err := strconv.Atoi(limitStr); err == nil && l > 0 {
			limit = l
		}
	}

	offset := 0
	if offsetStr := c.QueryParam("offset"); offsetStr != "" {
		if o, err := strconv.Atoi(offsetStr); err == nil && o >= 0 {
			offset = o
		}
	}

	ctx := c.Request().Context()

	chats, err := h.chatService.SearchChatByNickname(ctx, userID, query, limit, offset)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to search chats: " + err.Error(),
		})
	}

	if chats == nil {
		chats = make([]*models.ChatListItem, 0)
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"chats":   chats,
		"count":   len(chats),
		"query":   query,
	})
}
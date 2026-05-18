package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/services"
	"fakegram-api/internal/websocket/types"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/labstack/echo/v4"
)

type MessageHandler struct {
    messageService *services.MessageService
    wsPool         types.PoolInterface
}

func NewMessageHandler(messageService *services.MessageService, wsPool types.PoolInterface) *MessageHandler {
    return &MessageHandler{
        messageService: messageService,
        wsPool:         wsPool,
    }
}

// SendMessageHandler обработчик для отправки сообщений
// @Summary      Отправить сообщение
// @Description  Отправляет сообщение. Для существующих диалогов используйте chat_id, для новых - receiver_id
// @Tags         messages
// @Accept       json
// @Produce      json
// @Param        request body models.CreateMessageRequest true "Данные для отправки сообщения"
// @Success      201 {object} map[string]interface{} "Сообщение отправлено"
// @Failure      400 {object} map[string]string "Неверные данные запроса"
// @Failure      401 {object} map[string]string "Неавторизован"
// @Failure      403 {object} map[string]string "Доступ запрещен"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/messages/send [post]
func (h *MessageHandler) CreateMessage(c echo.Context) error {
    ctx := c.Request().Context()
    
    userID, ok := c.Get("userID").(string)
    if !ok || userID == "" {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{
            "error": "User not authenticated",
        })
    }

    var req models.CreateMessageRequest
    if err := c.Bind(&req); err != nil {
        return c.JSON(http.StatusBadRequest, map[string]interface{}{
            "error": "Invalid request body: " + err.Error(),
        })
    }

    if req.ChatID == "" && req.ReceiverID == "" {
        return c.JSON(http.StatusBadRequest, map[string]interface{}{
            "error": "Either chat_id or receiver_id must be provided",
        })
    }

    message, err := h.messageService.SendMessage(ctx, userID, &req)
    if err != nil {
        if err == services.ErrAccessDenied {
            return c.JSON(http.StatusForbidden, map[string]interface{}{
                "error": "Access denied to this dialog",
            })
        }
        if strings.Contains(err.Error(), "cannot send message to yourself") {
            return c.JSON(http.StatusBadRequest, map[string]interface{}{
                "error": "Cannot send message to yourself",
            })
        }
        return c.JSON(http.StatusInternalServerError, map[string]interface{}{
            "error": "Failed to send message: " + err.Error(),
        })
    }

    return c.JSON(http.StatusCreated, map[string]interface{}{
        "message": message,
        "chat_id": message.ChatID,
    })
}

// GetMessagesByChat получает сообщения из чата между двумя пользователями
// @Summary      Получить сообщения чата
// @Description  Возвращает сообщения из приватного чата с поддержкой двунаправленной пагинации.
// @Description  При первой загрузке (direction=around) автоматически позиционирует на первом непрочитанном сообщении.
// @Tags         messages
// @Accept       json
// @Produce      json
// @Param        user_id   path     string  true   "ID второго пользователя"
// @Param        direction query    string  false  "Направление загрузки: around (первая загрузка вокруг непрочитанного), older (старые сообщения), newer (новые сообщения)" default(around) Enums(around, older, newer)
// @Param        cursor    query    string  false  "Временная метка опорного сообщения в формате RFC3339 (например, 2024-01-02T15:04:05Z). Обязателен для direction=older или direction=newer"
// @Param        limit     query    int     false  "Количество сообщений (1-100)" default(30) mininum(1) maximum(100)
// @Success      200 {object} models.GetMessagesResponse "Список сообщений с информацией о пагинации"
// @Failure      400 {object} map[string]string "Неверные параметры (неверный direction, неверный формат cursor и т.д.)"
// @Failure      403 {object} map[string]string "Доступ запрещен (пользователь не является участником чата)"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/messages/private-chat/{user_id} [get]
func (h *MessageHandler) GetMessagesByChat(c echo.Context) error {
    ctx := c.Request().Context()
    
    currentUserID, ok := c.Get("userID").(string)
    if !ok || currentUserID == "" {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{
            "error": "User not authenticated",
        })
    }

    otherUserID := c.Param("user_id")
    if otherUserID == "" {
        return c.JSON(http.StatusBadRequest, map[string]interface{}{
            "error": "User ID is required",
        })
    }
    
    if currentUserID == otherUserID {
        return c.JSON(http.StatusBadRequest, map[string]interface{}{
            "error": "Cannot get messages with yourself",
        })
    }
    
    direction := c.QueryParam("direction")
    if direction == "" {
        direction = "around"
    }
    
    if direction != "around" && direction != "older" && direction != "newer" {
        return c.JSON(http.StatusBadRequest, map[string]interface{}{
            "error": "Invalid direction. Must be 'around', 'older', or 'newer'",
        })
    }
    
    var cursor *time.Time
    cursorStr := c.QueryParam("cursor")
    if cursorStr != "" {
        parsedTime, err := time.Parse(time.RFC3339, cursorStr)
        if err != nil {
            return c.JSON(http.StatusBadRequest, map[string]interface{}{
                "error": "Invalid cursor format. Use RFC3339 format (e.g., 2024-01-02T15:04:05Z)",
            })
        }
        cursor = &parsedTime
    }
    
    limit, _ := strconv.Atoi(c.QueryParam("limit"))
    if limit < 1 || limit > 100 {
        limit = 30
    }

    response, err := h.messageService.GetMessagesByChat(
        ctx, 
        currentUserID, 
        otherUserID, 
        cursor, 
        limit, 
        direction,
    )
    
    if err != nil {
        if err == services.ErrAccessDenied {
            return c.JSON(http.StatusForbidden, map[string]interface{}{
                "error": "Access denied to this chat",
            })
        }
        return c.JSON(http.StatusInternalServerError, map[string]interface{}{
            "error": "Failed to get messages: " + err.Error(),
        })
    }
    
    return c.JSON(http.StatusOK, response)
}

// DeleteMessage удаляет сообщение пользователя
// @Summary      Удалить сообщение
// @Description  Удаление сообщения. Только отправитель может удалить свое сообщение
// @Tags         messages
// @Accept       json
// @Produce      json
// @Param        message_id path string true "ID сообщения для удаления"
// @Success      200 {object} map[string]interface{} "Сообщение успешно удалено"
// @Failure      400 {object} map[string]string "Неверные параметры запроса"
// @Failure      401 {object} map[string]string "Неавторизован"
// @Failure      403 {object} map[string]string "Доступ запрещен"
// @Failure      404 {object} map[string]string "Сообщение не найдено"
// @Failure      500 {object} map[string]string "Ошибка сервера"
// @Security     BearerAuth
// @Router       /api/v1/messages/{message_id} [delete]
func (h *MessageHandler) DeleteMessage(c echo.Context) error {
	ctx := c.Request().Context()
	
	userID, ok := c.Get("userID").(string)
	if !ok || userID == "" {
		return c.JSON(http.StatusUnauthorized, map[string]interface{}{
			"error": "User not authenticated",
		})
	}

	messageID := c.Param("message_id")
	if messageID == "" {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"error": "Message ID is required",
		})
	}

	err := h.messageService.DeleteMessage(ctx, userID, messageID)
	if err != nil {
		switch err {
		case services.ErrAccessDenied:
			return c.JSON(http.StatusForbidden, map[string]interface{}{
				"error": "You can only delete your own messages",
			})
		case services.ErrMessageNotFound:
			return c.JSON(http.StatusNotFound, map[string]interface{}{
				"error": "Message not found",
			})
		default:
			if strings.Contains(err.Error(), "not a participant") {
				return c.JSON(http.StatusForbidden, map[string]interface{}{
					"error": "You are not a participant of this chat",
				})
			}
			return c.JSON(http.StatusInternalServerError, map[string]interface{}{
				"error": "Failed to delete message: " + err.Error(),
			})
		}
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"success": true,
		"message": "Message deleted successfully",
		"data": map[string]interface{}{
			"message_id": messageID,
			"deleted_by": userID,
		},
	})
}
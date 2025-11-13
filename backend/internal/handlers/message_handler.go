// internal/handlers/message.go
package handlers

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/services"
	wsMessage "fakegram-api/internal/websocket/messages"
	"net/http"
	"strconv"
	"strings"

	"github.com/labstack/echo/v4"
)

type MessageHandler struct {
    messageService *services.MessageService
    wsPool         *wsMessage.Pool
}

func NewMessageHandler(messageService *services.MessageService, wsPool *wsMessage.Pool) *MessageHandler {
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
// @Router       /api/v1/messages [post]
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
// @Description  Возвращает сообщения из приватного чата между двумя пользователями с автоматической отметкой о прочтении
// @Tags         messages
// @Accept       json
// @Produce      json
// @Param        user_id path string true "ID второго пользователя"
// @Param        page query int false "Номер страницы" default(1)
// @Param        limit query int false "Количество сообщений на странице" default(20)
// @Success      200 {object} models.GetMessagesResponse "Список сообщений"
// @Failure      400 {object} map[string]string "Неверные параметры"
// @Failure      403 {object} map[string]string "Доступ запрещен"
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
    
    page, _ := strconv.Atoi(c.QueryParam("page"))
    if page < 1 {
        page = 1
    }
    
    limit, _ := strconv.Atoi(c.QueryParam("limit"))
    if limit < 1 || limit > 100 {
        limit = 20
    }
    
    response, err := h.messageService.GetMessagesByChat(ctx, currentUserID, otherUserID, page, limit)
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
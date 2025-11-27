package messages

import (
	"log"
	"net/http"

	// "github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

type MessageWebSocketHandler struct {
    pool *Pool
}

func NewMessageWebSocketHandler(pool *Pool) *MessageWebSocketHandler {
    return &MessageWebSocketHandler{
        pool:           pool,
    }
}

func (h *MessageWebSocketHandler) MessageWebSocket(c echo.Context) error {
    userID := c.Get("userID")
    if userID == nil {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{"error": "Unauthorized"})
    }
    
    userIDStr, ok := userID.(string)
    if !ok || userIDStr == "" {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{"error": "Invalid user ID"})
    }

    conn, err := upgrader.Upgrade(c.Response(), c.Request(), nil)
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]interface{}{"error": "Failed to upgrade connection"})
    }

    client := &Client{
        UserID: userIDStr,
        Conn:   conn,
        Pool:   h.pool,
    }

    h.pool.Register <- client
    go client.Read()
    go client.StartTypingTimer()
    
    log.Printf("WebSocket client connected for user: %s", userIDStr)

    return nil
}
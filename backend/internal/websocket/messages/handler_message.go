package messages

import (
	"log"
	"net/http"
	"time"

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

    client := NewClient(userIDStr, conn, h.pool)

    h.pool.Register <- client
    go client.Read()
    go client.StartTypingTimer()
    // go client.StartPingTicker()

    welcomeEvent := WSEvent{
        Event: "connected",
        Data: map[string]interface{}{
            "user_id":    userIDStr,
            "timestamp":  time.Now().UnixMilli(),
            "message":    "WebSocket connection established",
        },
    }
    
    welcomeMsg := &Message{
        Type:    "event",
        Payload: mustMarshal(welcomeEvent),
    }
    
    if err := conn.WriteJSON(welcomeMsg); err != nil {
        log.Printf("Failed to send welcome message to user %s: %v", userIDStr, err)
    }
    
    log.Printf("WebSocket client connected for user: %s", userIDStr)

    return nil
}
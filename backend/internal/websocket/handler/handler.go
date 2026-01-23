package handler

import (
    "fakegram-api/internal/websocket/client"
    "fakegram-api/internal/websocket/pool"
    "fakegram-api/internal/websocket/types"
    "fakegram-api/internal/websocket/utils"
    "log"
    "net/http"
    "time"

    "github.com/gorilla/websocket"
    "github.com/labstack/echo/v4"
)

type WebSocketHandler struct {
    pool      types.PoolInterface
    router    types.EventHandler
    upgrader  websocket.Upgrader
}

func NewWebSocketHandler(pool types.PoolInterface, router types.EventHandler) *WebSocketHandler {
    return &WebSocketHandler{
        pool:   pool,
        router: router,
        upgrader: websocket.Upgrader{
            CheckOrigin: func(r *http.Request) bool {
                return true
            },
        },
    }
}

func (h *WebSocketHandler) HandleWebSocket(c echo.Context) error {
    userID := c.Get("userID")
    if userID == nil {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{"error": "Unauthorized"})
    }
    
    userIDStr, ok := userID.(string)
    if !ok || userIDStr == "" {
        return c.JSON(http.StatusUnauthorized, map[string]interface{}{"error": "Invalid user ID"})
    }

    conn, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
    if err != nil {
        return c.JSON(http.StatusInternalServerError, map[string]interface{}{"error": "Failed to upgrade connection"})
    }

    wsClient := client.NewClient(userIDStr, conn, h.pool)

    h.pool.(*pool.Pool).Register <- wsClient
    
    go wsClient.Read(h.router)
    go wsClient.StartTypingTimer()

    welcomeEvent := types.WSEvent{
        Event: types.EventConnected,
        Data: map[string]interface{}{
            "user_id":    userIDStr,
            "timestamp":  time.Now().UnixMilli(),
            "message":    "WebSocket connection established",
        },
    }
    
    welcomeMsg := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(welcomeEvent),
    }
    
    if err := conn.WriteJSON(welcomeMsg); err != nil {
        log.Printf("Failed to send welcome message to user %s: %v", userIDStr, err)
    }
    
    log.Printf("WebSocket client connected for user: %s", userIDStr)

    return nil
}
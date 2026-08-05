package handlers

import (
	"context"
	"fakegram-api/internal/services"
	"fakegram-api/internal/websocket/client"
	"fakegram-api/internal/websocket/events"
	"fakegram-api/internal/websocket/pool"
	"log"
	"net/http"
	"strings"
	"time"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

type WebSocketHandler struct {
    pool      events.PoolInterface
    router    events.EventHandler
    upgrader  websocket.Upgrader
    tokenService *services.TokenService
    chatService  *services.ChatService 
}

func NewWebSocketHandler(
    pool events.PoolInterface, 
    router events.EventHandler,
    tokenService *services.TokenService,
    chatService *services.ChatService,
    ) *WebSocketHandler {
    return &WebSocketHandler{
        pool:   pool,
        router: router,
        tokenService: tokenService,
        upgrader: websocket.Upgrader{
            ReadBufferSize:  1024,
	        WriteBufferSize: 1024,
            CheckOrigin: func(r *http.Request) bool {
                return true
            },
        },
    
    }
}

func (h *WebSocketHandler) HandleWebSocket(c echo.Context) error {
    log.Printf("=== WebSocket Connection ===")
    log.Printf("Path: %s", c.Path())
    log.Printf("Query: %s", c.Request().URL.RawQuery)
    log.Printf("Origin: %s", c.Request().Header.Get("Origin"))
    
    origin := c.Request().Header.Get("Origin")
    if origin != "" {
        c.Response().Header().Set("Access-Control-Allow-Origin", origin)
        c.Response().Header().Set("Access-Control-Allow-Credentials", "true")
        log.Printf("CORS headers set for origin: %s", origin)
    }
    conn, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
    if err != nil {
        log.Printf("WebSocket upgrade failed: %v", err)
        return c.JSON(http.StatusInternalServerError, map[string]interface{}{
            "error": "Failed to upgrade connection",
        })
    }
    
    var userIDStr string
    var tokenExpired bool
    
    contextUserID := c.Get("userID")
    if contextUserID != nil {
        if id, ok := contextUserID.(string); ok && id != "" {
            userIDStr = id
            log.Printf("Got userID from JWT context: %s", userIDStr)
        }
    }
    
    if userIDStr == "" {
        token := c.QueryParam("token")
        log.Printf("Token from query param: %s", token)
        
        if token == "" {
            log.Println("No token provided")
            sendErrorAndClose(conn, "missing_token", "Token required")
            return nil
        }
        
        claims, err := h.tokenService.ValidateAccessToken(token)
        if err != nil {
            log.Printf("Token validation failed: %v", err)
            
            if isTokenExpiredError(err) {
                log.Printf("Token expired, sending error to client")
                sendErrorAndClose(conn, "token_expired", "Token has expired")
                return nil
            }
            
            sendErrorAndClose(conn, "invalid_token", "Invalid token: " + err.Error())
            return nil
        }
        
        if claims.Subject == "" {
            log.Println("Token claims missing subject")
            sendErrorAndClose(conn, "invalid_token", "Token does not contain subject")
            return nil
        }
        
        userIDStr = claims.Subject
        log.Printf("User authenticated via token: %s", userIDStr)
    }
    
    if userIDStr == "" {
        log.Println("Could not determine user ID")
        errorMsg := map[string]interface{}{
            "type": "error",
            "code": "unknown_user",
            "message": "Could not identify user",
        }
        conn.WriteJSON(errorMsg)
        time.Sleep(100 * time.Millisecond)
        conn.Close()
        return nil
    }
    
    log.Printf("✅ WebSocket connected for user: %s (token expired: %v)", userIDStr, tokenExpired)
    
    wsClient := client.NewClient(userIDStr, conn, h.pool)
    
    if tokenExpired {
        go func() {
            time.Sleep(500 * time.Millisecond)
            expiredMsg := map[string]interface{}{
                "type": "token_expired",
                "message": "Your token has expired, please refresh",
            }
            if err := conn.WriteJSON(expiredMsg); err != nil {
                log.Printf("Failed to send token_expired event: %v", err)
            } else {
                log.Printf("Sent token_expired event to user: %s", userIDStr)
            }
        }()
    }
    
    go h.subscribeToUserChats(wsClient, userIDStr)
    
    h.pool.(*pool.Pool).Register <- wsClient
    
    go wsClient.Read(h.router)
    go wsClient.StartTypingTimer()
    
    log.Printf("WebSocket client fully connected for user: %s", userIDStr)
    
    return nil
}

func (h *WebSocketHandler) subscribeToUserChats(wsClient *client.Client, userID string) {
    if h.chatService == nil {
        log.Printf("Warning: chatService is nil, skipping chat subscription for user %s", userID)
        return
    }
    
    ctx := context.Background()
    
    chats, err := h.chatService.GetUserChats(ctx, userID)
    if err != nil {
        log.Printf("Error getting chats for user %s: %v", userID, err)
        return
    }
    
    chatIDs := make([]string, 0, len(chats))
    for _, chat := range chats {
        chatIDs = append(chatIDs, chat.ID)
    }
    
    wsClient.SubscribeToChats(chatIDs)
    
    log.Printf("User %s subscribed to %d chats: %v", userID, len(chatIDs), chatIDs)
}

func isTokenExpiredError(err error) bool {
    errStr := err.Error()
    return strings.Contains(errStr, "expired") || 
        strings.Contains(errStr, "token is expired") ||
        strings.Contains(errStr, "exp") ||
        strings.Contains(errStr, "token expired")
}

func sendErrorAndClose(conn *websocket.Conn, code string, message string) {
    errorMsg := map[string]interface{}{
        "type":    "error",
        "code":    code,
        "message": message,
    }
    
    if err := conn.WriteJSON(errorMsg); err != nil {
        log.Printf("Failed to send error message: %v", err)
    }

    time.Sleep(100 * time.Millisecond)
    conn.Close()
}
package handler

import (
	"fakegram-api/internal/services"
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
    tokenService *services.TokenService
}

func NewWebSocketHandler(
    pool types.PoolInterface, 
    router types.EventHandler,
    tokenService *services.TokenService,
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
    
	var userIDStr string
	
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
			return c.JSON(http.StatusUnauthorized, map[string]interface{}{
				"error": "Token required. Use ?token=JWT_TOKEN in URL",
			})
		}

		claims, err := h.tokenService.ValidateAccessToken(token)
		if err != nil {
			log.Printf("Token validation failed: %v", err)
			return c.JSON(http.StatusUnauthorized, map[string]interface{}{
				"error": "Invalid token: " + err.Error(),
			})
		}
		
		if claims.Subject == "" {
			log.Println("Token claims missing subject")
			return c.JSON(http.StatusUnauthorized, map[string]interface{}{
				"error": "Token does not contain subject",
			})
		}
		
		userIDStr = claims.Subject
		log.Printf("User authenticated via token: %s", userIDStr)
	}
	
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
	
	log.Printf("✅ WebSocket connected for user: %s", userIDStr)
	
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
		log.Printf("Failed to send welcome message: %v", err)
	} else {
		log.Printf("Welcome message sent to user: %s", userIDStr)
	}
	
	log.Printf("WebSocket client fully connected for user: %s", userIDStr)
	
	return nil
}
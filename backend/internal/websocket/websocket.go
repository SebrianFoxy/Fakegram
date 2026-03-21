package websocket

import (
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/services"
	"fakegram-api/internal/websocket/events"
	"fakegram-api/internal/websocket/handler"
	"fakegram-api/internal/websocket/pool"
	"fakegram-api/internal/websocket/types"
)

type WebSocketManager struct {
    Pool    *pool.Pool
    Router  *events.Router
    Handler *handler.WebSocketHandler
    TokenService *services.TokenService
    MessageRepo    *repositories.MessageRepository
}

func NewWebSocketManager(
    tokenService *services.TokenService,
    messageRepo *repositories.MessageRepository,
    ) *WebSocketManager {
    p := pool.NewPool()
    
    r := events.NewRouter()
    
    messageHandlers := events.NewMessageHandlers(messageRepo, p)
    typingHandlers := events.NewTypingHandlers(p)
    
    r.Register("message_read", messageHandlers.CreateMessageReadHandler())
    r.Register("typing_start", typingHandlers.CreateTypingStartHandler())
    r.Register("typing_stop", typingHandlers.CreateTypingStopHandler())
    r.Register("new_message", messageHandlers.CreateNewMessageHandler())
    
    h := handler.NewWebSocketHandler(p, r, tokenService)
    
    go p.Start()
    
    return &WebSocketManager{
        Pool:    p,
        Router:  r,
        Handler: h,
        TokenService: tokenService,
        MessageRepo:  messageRepo,
    }
}

func (m *WebSocketManager) GetPool() types.PoolInterface {
    return m.Pool
}

func (m *WebSocketManager) GetHandler() *handler.WebSocketHandler {
    return m.Handler
}
package websocket

import (
    "fakegram-api/internal/websocket/events"
    "fakegram-api/internal/websocket/handler"
    "fakegram-api/internal/websocket/pool"
    "fakegram-api/internal/websocket/types"
)

type WebSocketManager struct {
    Pool    *pool.Pool
    Router  *events.Router
    Handler *handler.WebSocketHandler
}

func NewWebSocketManager() *WebSocketManager {
    p := pool.NewPool()
    
    r := events.NewRouter()
    
    messageHandlers := events.NewMessageHandlers(p)
    typingHandlers := events.NewTypingHandlers(p)
    
    r.Register("message_read", messageHandlers.CreateMessageReadHandler())
    r.Register("typing_start", typingHandlers.CreateTypingStartHandler())
    r.Register("typing_stop", typingHandlers.CreateTypingStopHandler())
    r.Register("new_message", messageHandlers.CreateNewMessageHandler())
    
    h := handler.NewWebSocketHandler(p, r)
    
    go p.Start()
    
    return &WebSocketManager{
        Pool:    p,
        Router:  r,
        Handler: h,
    }
}

func (m *WebSocketManager) GetPool() types.PoolInterface {
    return m.Pool
}

func (m *WebSocketManager) GetHandler() *handler.WebSocketHandler {
    return m.Handler
}
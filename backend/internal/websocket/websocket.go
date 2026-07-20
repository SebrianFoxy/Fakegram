package websocket

import (
	"fakegram-api/internal/services"
	"fakegram-api/internal/websocket/events"
	"fakegram-api/internal/websocket/handlers"
	"fakegram-api/internal/websocket/pool"
)

type WebSocketManager struct {
	Pool    *pool.Pool
	Handler *handlers.WebSocketHandler
}

func NewWebSocketManager(
	tokenService *services.TokenService,
	messageService *services.MessageService,
	chatService *services.ChatService,
) *WebSocketManager {
	p := pool.NewPool()
	
	chatNotifier := events.NewChatWsNotifier(p)
	messageNotifier := events.NewMessageWsNotifier(p)

	messageService.SetNotifier(messageNotifier, chatNotifier)
	chatService.SetNotifier(chatNotifier)
	
	messageHandlers := handlers.NewMessageHandlers(messageService)
	
	r := events.NewRouter()
	r.Register("new_message", messageHandlers.CreateNewMessageHandler())
	r.Register("message_read", messageHandlers.CreateMessageReadHandler())
	r.Register("message_read_all", messageHandlers.CreateMessageReadAllHandler())
	r.Register("message_delete", messageHandlers.CreateDeleteMessageHandler())
	r.Register("message_edit", messageHandlers.CreateEditMessageHandler())
	
	h := handlers.NewWebSocketHandler(p, r, tokenService, chatService)
	
	go p.Start()
	
	return &WebSocketManager{
		Pool:    p,
		Handler: h,
	}
}

func (m *WebSocketManager) GetPool() *pool.Pool {
	return m.Pool
}

func (m *WebSocketManager) GetHandler() *handlers.WebSocketHandler {
	return m.Handler
}
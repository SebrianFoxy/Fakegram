package events

import (
	"context"
	"encoding/json"
	"fakegram-api/internal/models"
	"fakegram-api/internal/websocket/types"

	"github.com/gorilla/websocket"
)

type EventHandler interface {
    Handle(clientID string, eventType string, payload json.RawMessage) error
}

type EventHandlerFunc func(clientID string, eventType string, payload json.RawMessage) error

func (f EventHandlerFunc) Handle(clientID string, eventType string, payload json.RawMessage) error {
    return f(clientID, eventType, payload)
}

type ClientInterface interface {
    GetUserID() string
    GetConn() *websocket.Conn
    SendMessage(message *types.Message) error
    Close()
    
    IsInChat(chatID string) bool
    JoinChat(chatID string)                   
    LeaveChat(chatID string)                   
    SubscribeToChats(chatIDs []string)                         
    
    GetActiveChat() string
    SetActiveChat(chatID string)
    GetLastTyping() int64
    SetLastTyping(timestamp int64)
    ResetTyping()
}

type PoolInterface interface {
    BroadcastToChat(chatID string, message *types.Message, excludeUserID string)
    SendToUser(userID string, message *types.Message) error
    GetClient(userID string) ClientInterface
    UnregisterClient(client ClientInterface)
    IsUserOnline(userID string) bool
    GetOnlineUsers() []string
}

type ChatRepository interface {
	GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error)
}
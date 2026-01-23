package types

import (
    "encoding/json"
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
    SendMessage(message *Message) error
    Close()
    GetActiveChat() string
    SetActiveChat(chatID string)
    GetLastTyping() int64
    SetLastTyping(timestamp int64)
    ResetTyping()
}

type PoolInterface interface {
    BroadcastToChat(chatID string, message *Message, excludeUserID string)
    SendToUser(userID string, message *Message) error
    GetClient(userID string) ClientInterface
    UnregisterClient(client ClientInterface)
    NotifyChatListUpdate(userID string, chat interface{})
    IsUserOnline(userID string) bool
    GetOnlineUsers() []string
}
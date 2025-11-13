package messages

import "encoding/json"

const (
    EventMessageSent    = "message_sent"
    EventMessageUpdated = "message_updated"
    EventMessageDeleted = "message_deleted"
    EventUserTyping     = "user_typing"
    EventUserOnline     = "user_online"
    EventUserOffline    = "user_offline"
    EventMessageRead    = "message_read"   
    EventError          = "error"
)

type Message struct {
    Type    string          `json:"type"`
    Payload json.RawMessage `json:"payload"`
}

type WSEvent struct {
    Event string      `json:"event"`
    Data  interface{} `json:"data"`
}
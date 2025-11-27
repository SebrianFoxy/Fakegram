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
    EventMessageError   = "message_error"
)

const (
    EventChatListUpdate   = "chat_list_update"
    EventNewChatCreated   = "new_chat_created"  
)

type Message struct {
    Type    string          `json:"type"`
    Payload json.RawMessage `json:"payload"`
}

type WSEvent struct {
    Event string      `json:"event"`
    Data  interface{} `json:"data"`
}
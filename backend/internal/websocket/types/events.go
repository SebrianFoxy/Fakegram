package types

const (
    EventUserTyping     = "user_typing"
    EventUserOnline     = "user_online"
    EventUserOffline    = "user_offline"
)

const (
    EventMessageRead    = "message_read" 
    EventMessageReadAll = "message_read_all"  
    EventMessageError   = "message_error"
    EventMessageSent    = "message_sent"
    EventMessageEdited  = "message_edited"
    EventMessageDeleted = "message_deleted"
    EventMessageListUpdate = "message_list_update"
)

const (
    EventChatListUpdate = "chat_list_update"
    EventNewChatCreated = "new_chat_created"
)

const (
    EventUnreadCountUpdate = "unread_count_update"
)

const (
    EventPing           = "ping"          
    EventPong           = "pong"  
    EventConnected      = "connected"  
)
package models

import (
	"errors"
	"time"
)

type MessageType string

const (
    MessageTypeText  MessageType = "text"
    MessageTypeImage MessageType = "image"
    MessageTypeFile  MessageType = "file"
)

var (
    ErrMessageNotFound    = errors.New("message not found")
    ErrEmptyChatID        = errors.New("chat ID cannot be empty")
    ErrEmptySenderID      = errors.New("sender ID cannot be empty")
    ErrEmptyOtherUserID   = errors.New("other user ID cannot be empty")
    ErrEmptyMessageText   = errors.New("message text cannot be empty for text messages")
    ErrInvalidMessageType = errors.New("invalid message type")
    ErrInvalidDirection   = errors.New("invalid direction, must be around, older, or newer")
)

type Message struct {
    ID               string    `json:"id" db:"id"`
    ChatID           string    `json:"chat_id" db:"chat_id"`
    SenderID         string    `json:"sender_id" db:"sender_id" validate:"required,uuid4"`
    MessageText      string    `json:"message_text" db:"message_text"`
    MessageType      MessageType `json:"message_type" db:"message_type"`
    ReplyToMessageID *string   `json:"reply_to_message_id,omitempty" db:"reply_to_message_id" validate:"uuid4"`
    IsEdited         bool      `json:"is_edited" db:"is_edited"`
    IsDeleted        bool      `json:"is_deleted" db:"is_deleted"`
    CreatedAt        time.Time `json:"created_at" db:"created_at"`
    UpdatedAt        time.Time `json:"updated_at" db:"updated_at"`
}

type CreateMessageRequest struct {
	ChatID           string      `json:"chat_id" validate:"required"`
	MessageText      string      `json:"message_text" validate:"required"`
    ReceiverID       string      `json:"receiver_id,omitempty"`
	MessageType      MessageType `json:"message_type" validate:"required,oneof=text image file video audio"`
	ReplyToMessageID *string     `json:"reply_to_message_id,omitempty" validate:"omitempty,uuid4"`
}

type GetMessagesRequest struct {
    OtherUserID string     `json:"other_user_id" validate:"required"`
    Cursor      *time.Time `json:"cursor,omitempty"`              
    Limit       int        `json:"limit,omitempty" validate:"omitempty,min=1,max=100"`
    Direction   string     `json:"direction" validate:"required,oneof=around older newer"` 
}

type GetMessagesResponse struct {
    Messages      []*MessageDetail `json:"messages"`
    Count         int              `json:"count"`                    
    TotalUnread   int64            `json:"total_unread"`             
    HasMoreOlder  bool             `json:"has_more_older"`           
    HasMoreNewer  bool             `json:"has_more_newer"`           
    FirstMsgTime  *time.Time       `json:"first_msg_time,omitempty"` 
    LastMsgTime   *time.Time       `json:"last_msg_time,omitempty"`  
    Cursors       *MessageCursors   `json:"cursors,omitempty"`        
}

type MessageCursors struct {
    Older *time.Time `json:"older,omitempty"`
    Newer *time.Time `json:"newer,omitempty"`
}

type MessageReadInfo struct {
    UserID    string    `json:"user_id"`
    Name      string    `json:"name"`
    Surname   string    `json:"surname"`
    Nickname  string    `json:"nickname"`
    AvatarURL *string   `json:"avatar_url,omitempty"`
    ReadAt    time.Time `json:"read_at"`
}

type MessageDetail struct {
    *Message
    IsRead          bool         `json:"is_read"`
    ReadAt          *time.Time   `json:"read_at,omitempty"`
    ReadBy          []*MessageReadInfo `json:"read_by,omitempty"`
    Sender          *UserDetail  `json:"sender"`
    ReplyToMessage  *MessageDetail `json:"reply_to_message,omitempty"`
}

type UserDetail struct {
    Name      string  `json:"name"`
    Surname   string  `json:"surname"`
    Nickname  string  `json:"nickname"`
    AvatarURL *string `json:"avatar_url,omitempty"`
}

type UpdateMessageRequest struct {
    MessageText string `json:"message_text" validate:"required"`
}
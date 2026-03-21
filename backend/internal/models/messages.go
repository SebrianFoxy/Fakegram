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

type MessageDetail struct {
    *Message
    IsRead          bool         `json:"is_read"`
    ReadAt          *time.Time   `json:"read_at,omitempty"`
    Sender          *UserDetail  `json:"sender"`
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

type MarkAsReadRequest struct {
    ChatID             string `json:"chat_id" validate:"required"`
    LastReadMessageID  string `json:"last_read_message_id" validate:"required,uuid4"`
}

type MessageReadStatus struct {
    ID        string    `json:"id" db:"id"`
    MessageID string    `json:"message_id" db:"message_id"`
    UserID    string    `json:"user_id" db:"user_id"`
    ReadAt    time.Time `json:"read_at" db:"read_at"`
}

type UnreadCountResponse struct {
    ChatID      string `json:"chat_id"`
    UnreadCount int    `json:"unread_count"`
    TotalUnread int    `json:"total_unread,omitempty"` 
}

type MessageWithReadStatus struct {
	*Message                     
	IsRead          bool        `json:"is_read"`
	ReadAt          *time.Time  `json:"read_at,omitempty"`
}

type MessageResponse struct {
	*Message
	SenderUsername string `json:"sender_username,omitempty"`
	SenderName     string `json:"sender_name,omitempty"`
	ChatTitle      string `json:"chat_title,omitempty"`
}

func CreateMessage(chatID, senderID, messageText string, messageType MessageType) *Message {
	return &Message{
		ChatID:      chatID,
		SenderID:    senderID,
		MessageText: messageText,
		MessageType: messageType,
		IsEdited:    false,
		IsDeleted:   false,
		CreatedAt:   time.Now(),
	}
}

func CreateMessageWithReadStatus(msg *Message, isRead bool, readAt *time.Time) *MessageWithReadStatus {
	return &MessageWithReadStatus{
		Message: msg,
		IsRead:  isRead,
		ReadAt:  readAt,
	}
}

func ToMessageDetail(msg *Message, isRead bool, readAt *time.Time, sender *UserDetail) *MessageDetail {
	return &MessageDetail{
		Message: msg,
		IsRead:  isRead,
		ReadAt:  readAt,
		Sender:  sender,
	}
}

func ToGetMessagesResponse(messages []*MessageDetail, totalUnread int64, hasMoreOlder, hasMoreNewer bool) *GetMessagesResponse {
    resp := &GetMessagesResponse{
        Messages:     messages,
        Count:        len(messages),
        TotalUnread:  totalUnread,
        HasMoreOlder: hasMoreOlder,
        HasMoreNewer: hasMoreNewer,
    }
    
    if len(messages) > 0 {
        firstMsgTime := messages[0].CreatedAt
        lastMsgTime := messages[len(messages)-1].CreatedAt
        resp.FirstMsgTime = &firstMsgTime
        resp.LastMsgTime = &lastMsgTime

        resp.Cursors = &MessageCursors{}
        if hasMoreOlder {
            resp.Cursors.Older = &firstMsgTime
        }
        if hasMoreNewer {
            resp.Cursors.Newer = &lastMsgTime
        }
    }
    
    return resp
}

func ToEmptyGetMessagesResponse() *GetMessagesResponse {
    return &GetMessagesResponse{
        Messages:      []*MessageDetail{},
        Count:         0,
        TotalUnread:   0,
        HasMoreOlder:  false,
        HasMoreNewer:  false,
    }
}

func CreateTextMessage(chatID, senderID, text string) *Message {
	return CreateMessage(chatID, senderID, text, MessageTypeText)
}

func (m *Message) WithReply(replyToMessageID string) *Message {
	m.ReplyToMessageID = &replyToMessageID
	return m
}

func (m *Message) MarkAsEdited() {
	m.IsEdited = true
}

func (m *Message) MarkAsDeleted() {
	m.IsDeleted = true
}

func (m *Message) Validate() error {
    if m.ChatID == "" {
        return ErrEmptyChatID
    }
    if m.SenderID == "" {
        return ErrEmptySenderID
    }
    if m.MessageText == "" && m.MessageType == MessageTypeText {
        return ErrEmptyMessageText
    }
    return nil
}

func (r *GetMessagesRequest) Validate() error {
    if r.OtherUserID == "" {
        return ErrEmptyOtherUserID
    }
    if r.Direction != "around" && r.Direction != "older" && r.Direction != "newer" {
        return ErrInvalidDirection
    }
    if r.Limit <= 0 || r.Limit > 100 {
        r.Limit = 30
    }
    return nil
}

var (
    ErrMessageNotFound    = errors.New("message not found")
    ErrEmptyChatID        = errors.New("chat ID cannot be empty")
    ErrEmptySenderID      = errors.New("sender ID cannot be empty")
    ErrEmptyOtherUserID   = errors.New("other user ID cannot be empty")
    ErrEmptyMessageText   = errors.New("message text cannot be empty for text messages")
    ErrInvalidMessageType = errors.New("invalid message type")
    ErrInvalidDirection   = errors.New("invalid direction, must be around, older, or newer")
)
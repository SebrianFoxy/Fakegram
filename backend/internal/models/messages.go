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
    ID               string   	 `json:"id" db:"id"`
    ChatID           string   	 `json:"chat_id" db:"chat_id"`
    SenderID         string  	 `json:"sender_id" db:"sender_id" validate:"required,uuid4"`
    MessageText      string      `json:"message_text" db:"message_text"`
    MessageType      MessageType `json:"message_type" db:"message_type"`
    ReplyToMessageID *string  	 `json:"reply_to_message_id,omitempty" db:"reply_to_message_id" validate:"uuid4"`
    IsEdited         bool        `json:"is_edited" db:"is_edited"`
    IsDeleted        bool        `json:"is_deleted" db:"is_deleted"`
    CreatedAt        time.Time   `json:"created_at" db:"created_at"`
}

type CreateMessageRequest struct {
	ChatID           string      `json:"chat_id" validate:"required"`
	MessageText      string      `json:"message_text" validate:"required"`
    ReceiverID       string      `json:"receiver_id,omitempty"`
	MessageType      MessageType `json:"message_type" validate:"required,oneof=text image file video audio"`
	ReplyToMessageID *string     `json:"reply_to_message_id,omitempty" validate:"omitempty,uuid4"`
}

type GetMessagesResponse struct {
    Messages []*MessageDetail `json:"messages"`
    Count    int              `json:"count"`
    Total    int              `json:"total"`
    Page     int              `json:"page"`
    Limit    int              `json:"limit"`
    HasNext  bool             `json:"has_next"`
    HasPrev  bool             `json:"has_prev"`
}

type MessageDetail struct {
    ID               string      `json:"id"`
    ChatID           string      `json:"chat_id"`
    SenderID         string      `json:"sender_id"`
    SenderName       string      `json:"sender_name"`
    SenderSurname    string      `json:"sender_surname"`
    SenderNickname   string      `json:"sender_nickname"`
    SenderAvatarURL  *string     `json:"sender_avatar_url,omitempty"`
    MessageText      string      `json:"message_text"`
    MessageType      MessageType `json:"message_type"`
    ReplyToMessageID *string     `json:"reply_to_message_id,omitempty"`
    IsEdited         bool        `json:"is_edited"`
    IsDeleted        bool        `json:"is_deleted"`
    IsRead           bool        `json:"is_read"`
    CreatedAt        time.Time   `json:"created_at"`
}

type UpdateMessageRequest struct {
	MessageText string `json:"message_text" validate:"required"`
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

func (m *Message) ToMessageDetail(sender *User) *MessageDetail {
    return &MessageDetail{
        ID:               m.ID,
        ChatID:           m.ChatID,
        SenderID:         m.SenderID,
        SenderName:       sender.Name,
        SenderSurname:    sender.Surname,
        SenderNickname:   sender.Nickname,
        SenderAvatarURL:  sender.AvatarURL,
        MessageText:      m.MessageText,
        MessageType:      m.MessageType,
        ReplyToMessageID: m.ReplyToMessageID,
        IsEdited:         m.IsEdited,
        IsDeleted:        m.IsDeleted,
        IsRead:           false,
        CreatedAt:        m.CreatedAt,
    }
}

func ToGetMessagesResponse(messages []*MessageDetail, page, limit, total int) *GetMessagesResponse {
    hasNext := (page * limit) < total
    hasPrev := page > 1
    
    return &GetMessagesResponse{
        Messages: messages,
        Count:    len(messages),
        Total:    total,
        Page:     page,
        Limit:    limit,
        HasNext:  hasNext,
        HasPrev:  hasPrev,
    }
}

var (
    ErrMessageNotFound   = errors.New("message not found")
    ErrEmptyChatID       = errors.New("chat ID cannot be empty")
    ErrEmptySenderID     = errors.New("sender ID cannot be empty")
    ErrEmptyMessageText  = errors.New("message text cannot be empty for text messages")
    ErrInvalidMessageType = errors.New("invalid message type")
)
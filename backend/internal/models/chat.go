package models

import (
	"time"
)

type ChatType string

const (
	ChatTypePrivate ChatType = "private"
	ChatTypeGroup   ChatType = "group"
)

type ChatListItem struct {
	ID              string     `json:"id"`
	ChatType        ChatType   `json:"chat_type"`
	Title           string     `json:"title,omitempty"`
	Description 	string     `json:"description,omitempty" db:"description"`
	AvatarURL   	string     `json:"avatar_url,omitempty" db:"avatar_url"`
	CreatedBy   	string     `json:"created_by,omitempty" db:"created_by"`
	IsDeleted   	bool       `json:"is_deleted" db:"is_deleted"`
	LastMessage     *Message   `json:"last_message,omitempty"`
	UnreadCount     int        `json:"unread_count"`
	OtherUser       *User      `json:"other_user,omitempty"`
	Members         []*User    `json:"members,omitempty"`  
	CreatedAt   	time.Time  `json:"created_at" db:"created_at"`
	UpdatedAt       time.Time  `json:"updated_at" db:"updated_at"`
}

type CreateGroupChatRequest struct {
	Title       string   `json:"title" validate:"required,min=1,max=255"`
	Description string   `json:"description,omitempty" validate:"omitempty,max=1000"`
	AvatarURL   string   `json:"avatar_url,omitempty" validate:"omitempty,url"`
	MemberIDs   []string `json:"member_ids" validate:"required,min=1,dive,uuid4"`
}

type ChatMember struct {
	ID       string    `json:"id" db:"id"`
	ChatID   string    `json:"chat_id" db:"chat_id"`
	UserID   string    `json:"user_id" db:"user_id"`
	Role     string    `json:"role" db:"role"`
	JoinedAt time.Time `json:"joined_at" db:"joined_at"`
}
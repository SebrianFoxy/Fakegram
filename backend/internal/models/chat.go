package models

import (
	"fmt"
	"strings"
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
	AvatarURL       string     `json:"avatar_url,omitempty"`
	LastMessage     *Message   `json:"last_message,omitempty"`
	UnreadCount     int        `json:"unread_count"`
	OtherUser       *User      `json:"other_user,omitempty"`
	Members         []*User    `json:"members,omitempty"`  
	UpdatedAt       time.Time  `json:"updated_at"`
}

type ChatUser struct {
	ID        string `json:"id"`
	Name      string `json:"name"`
	Surname   string `json:"surname"`
	Nickname  string `json:"nickname"`
	AvatarURL string `json:"avatar_url,omitempty"`
	IsOnline  bool   `json:"is_online"`
}

type PrivateChatRequest struct {
	ReceiverID string `json:"receiver_id" validate:"required,uuid4"`
}

func GenerateChatID(user1ID, user2ID string) string {
    if user1ID < user2ID {
        return "private_" + user1ID + "_" + user2ID
    }
    return "private_" + user2ID + "_" + user1ID
}

func ExtractUsersFromChatID(chatID string) (string, string, error) {
    if !strings.HasPrefix(chatID, "private_") {
        return "", "", fmt.Errorf("invalid chat ID format: must start with 'private_'")
    }
    
    usersPart := strings.TrimPrefix(chatID, "private_")
    
    parts := strings.Split(usersPart, "_")
    if len(parts) != 2 {
        return "", "", fmt.Errorf("invalid chat ID format: expected 2 user IDs")
    }
    
    user1ID := parts[0]
    user2ID := parts[1]
    
    if user1ID == "" || user2ID == "" {
        return "", "", fmt.Errorf("invalid chat ID format: user IDs cannot be empty")
    }
    
    return user1ID, user2ID, nil
}

func IsPrivateChat(chatID string) bool {
    return strings.HasPrefix(chatID, "private_")
}

func GetOtherUserID(chatID, currentUserID string) (string, error) {
    user1ID, user2ID, err := ExtractUsersFromChatID(chatID)
    if err != nil {
        return "", err
    }
    
    if user1ID == currentUserID {
        return user2ID, nil
    } else if user2ID == currentUserID {
        return user1ID, nil
    }
    
    return "", fmt.Errorf("current user is not a participant of this chat")
}

func ValidateChatID(chatID string) error {
    if !IsPrivateChat(chatID) {
        return fmt.Errorf("chat ID must start with 'private_'")
    }
    
    _, _, err := ExtractUsersFromChatID(chatID)
    return err
}
package handlers

import (
	"context"
	"fakegram-api/internal/models"
)

type MessageServiceInterface interface {
	SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.MessageDetail, error)
	DeleteMessage(ctx context.Context, userID, messageID string) error
	EditMessage(ctx context.Context, userID, messageID string, req *models.UpdateMessageRequest) (*models.MessageDetail, error)
	MarkAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error
	MarkAllAsRead(ctx context.Context, userID, chatID string) error
}

type ChatServiceInterface interface {
	GetUserChats(ctx context.Context, userID string, limit, offset int) ([]*models.ChatListItem, int, error)
	SearchChatByNickname(ctx context.Context, userID, query string, limit, offset int) ([]*models.ChatListItem, error)
}
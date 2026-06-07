package services

import (
	"context"
	"fmt"
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
)

type ChatService struct {
	chatRepo *repositories.ChatRepository
}

func NewChatService(chatRepo *repositories.ChatRepository) *ChatService {
	return &ChatService{
		chatRepo: chatRepo,
	}
}

func (s *ChatService) GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error) {
	if userID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	chats, err := s.chatRepo.GetUserChats(ctx, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get user chats: %w", err)
	}
	
	return chats, nil;
}

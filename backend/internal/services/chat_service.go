package services

import (
	"context"
	"fakegram-api/internal/models"
	"fmt"
	"log"
	"strings"
)

type ChatService struct {
	chatRepo ChatRepository
	chatNotifier ChatNotifier
}

func NewChatService(
	chatRepo ChatRepository,
	chatNotifier ChatNotifier,
	) *ChatService {
	return &ChatService{
		chatRepo: chatRepo,
		chatNotifier: chatNotifier,
	}
}

func (s *ChatService) SetNotifier(chatNotifier ChatNotifier) {
	s.chatNotifier = chatNotifier
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

func (s *ChatService) SearchChatByNickname(ctx context.Context, currentUserID, query string, limit, offset int) ([]*models.ChatListItem, error) {
	if currentUserID == "" {
		return nil, fmt.Errorf("current user ID is required")
	}
	
	if query == "" {
		return nil, fmt.Errorf("search query is required")
	}

	if limit <= 0 {
		limit = 20
	}

	if limit > 100 {
		limit = 100
	}

	if offset < 0 {
		offset = 0
	}

	query = strings.TrimSpace(query)
	
	if len(query) < 2 {
		return nil, fmt.Errorf("search query must be at least 2 characters long")
	}

	if len(query) > 100 {
		return nil, fmt.Errorf("search query is too long")
	}

	results, err := s.chatRepo.SearchChatByNickname(ctx, query, currentUserID, limit, offset)
	if err != nil {
		return nil, fmt.Errorf("failed to search chats: %w", err)
	}

	return results, nil
}

func (s *ChatService) UpdateChatListForParticipants(ctx context.Context, chatID string, excludeUserID string) {
	user1, user2, err := models.ExtractUsersFromChatID(chatID)
	if err != nil {
		log.Printf("Error extracting users from chat ID: %v", err)
		return
	}

	participants := []string{user1, user2}

	log.Printf("🟢 Updating chat list for participants: %v, exclude: %s", participants, excludeUserID)

	for _, participantID := range participants {
		if participantID == excludeUserID {
			log.Printf("🟡 Skipping notification for excluded user: %s", participantID)
			continue
		}

		log.Printf("🟢 Getting chats for user: %s", participantID)

		chats, err := s.chatRepo.GetUserChats(ctx, participantID)
		if err != nil {
			log.Printf("Error getting user chats for notification: %v", err)
			continue
		}

		var updatedChat *models.ChatListItem
		for _, chat := range chats {
			if chat.ID == chatID {
				updatedChat = chat
				break
			}
		}

		if updatedChat != nil {
			log.Printf("🟢 Sending chat update to user %s for chat %s", participantID, chatID)
			s.chatNotifier.NotifyChatListUpdate(participantID, updatedChat, excludeUserID)
		} else {
			log.Printf("❌ Chat not found for user %s", participantID)
		}
	}
}
package services

import (
	"context"
	"fakegram-api/internal/models"
	"fmt"
	"strings"
)

type ChatService struct {
	chatRepo ChatRepository
	chatNotifier ChatNotifier
	cryptoService CryptoService
}

func NewChatService(
	chatRepo ChatRepository,
	chatNotifier ChatNotifier,
	cryptoService CryptoService,
	) *ChatService {
	return &ChatService{
		chatRepo: chatRepo,
		chatNotifier: chatNotifier,
		cryptoService: cryptoService,
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

	s.decryptLastMessages(chats)
	
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

	s.decryptLastMessages(results)

	return results, nil
}

func (s *ChatService) decryptLastMessages(chats []*models.ChatListItem) {
	for i, chat := range chats {
		if chat.LastMessage == nil || chat.LastMessage.MessageText == "" {
			continue
		}

		userText, err := s.cryptoService.DecryptMessage(chat.LastMessage.MessageText)
		if err != nil {
			chats[i].LastMessage.MessageText = "[encrypted]"
			continue
		}
		chats[i].LastMessage.MessageText = string(userText)
	}
}
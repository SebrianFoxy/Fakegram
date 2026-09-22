package services

import (
	"context"
	"fakegram-api/internal/models"
	"fmt"
	"log"
	"strings"

	"github.com/google/uuid"
)

type ChatService struct {
	userRepo UserRepository
	chatRepo ChatRepository
	chatNotifier ChatNotifier
	cryptoService CryptoService
}

func NewChatService(
	userRepo UserRepository,
	chatRepo ChatRepository,
	chatNotifier ChatNotifier,
	cryptoService CryptoService,
	) *ChatService {
	return &ChatService{
		userRepo: userRepo,
		chatRepo: chatRepo,
		chatNotifier: chatNotifier,
		cryptoService: cryptoService,
	}
}

func (s *ChatService) SetNotifier(chatNotifier ChatNotifier) {
	s.chatNotifier = chatNotifier
}

func (s *ChatService) CreateGroupChat(ctx context.Context, creatorID string, req *models.CreateGroupChatRequest) (*models.ChatListItem, error) {
	if creatorID == "" {
		return nil, fmt.Errorf("creator ID is required")
	}
	if req.Title == "" && len(req.MemberIDs) < 2 {
		return nil, fmt.Errorf("title is required for group chat")
	}
	if len(req.MemberIDs) < 1 {
		return nil, fmt.Errorf("at least one member is required")
	}

	uniqueMembers := make([]string, 0, len(req.MemberIDs))
	seen := make(map[string]bool)
	
	uniqueMembers = append(uniqueMembers, creatorID)
	seen[creatorID] = true
	
	for _, memberID := range req.MemberIDs {
		if memberID == creatorID {
			continue
		}
		if !seen[memberID] {
			uniqueMembers = append(uniqueMembers, memberID)
			seen[memberID] = true
		}
	}

	allExist, err := s.userRepo.CheckUsersApproved(ctx, uniqueMembers...)
	if err != nil {
		return nil, fmt.Errorf("failed to check users: %w", err)
	}
	if !allExist {
		return nil, fmt.Errorf("one or more users do not exist")
	}

	chatID := s.GenerateGroupChatID()

	chat, err := s.chatRepo.CreateGroupChat(ctx, chatID, req.Title, req.Description, req.AvatarURL, creatorID)
	if err != nil {
		return nil, fmt.Errorf("failed to create group chat: %w", err)
	}

	if err := s.chatRepo.AddChatMembers(ctx, chatID, uniqueMembers, "member"); err != nil {
		return nil, fmt.Errorf("failed to add chat members: %w", err)
	}

	if err := s.chatRepo.AddChatMember(ctx, chatID, creatorID, "admin"); err != nil {
		log.Printf("Warning: failed to set creator as admin: %v", err)
	}

	chatItem := &models.ChatListItem{
		ID:        chatID,
		ChatType:  models.ChatTypeGroup,
		Title:     chat.Title,
		AvatarURL: chat.AvatarURL,
		UpdatedAt: chat.CreatedAt,
	}

	for _, memberID := range uniqueMembers {
		s.chatNotifier.SubscribeToChat(memberID, chatID)
		s.chatNotifier.NotifyChatListUpdate(chatID, chatItem, memberID)
	}

	log.Printf("Group chat %s created by user %s with %d members", chatID, creatorID, len(uniqueMembers))
	return chatItem, nil
}

func (s *ChatService) GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error) {
	if userID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	chats, err := s.chatRepo.GetUserChats(ctx, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get user chats: %w", err)
	}

	s.decryptChatList(chats)
	
	return chats, nil;
}

func (s *ChatService) GetChatByID(ctx context.Context, chatID, userID string) (*models.ChatListItem, error) {
	if chatID == "" {
		return nil, fmt.Errorf("chat ID is required")
	}
	if userID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	isMember, err := s.IsUserInDialog(ctx, chatID, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to check user membership: %w", err)
	}
	if !isMember {
		return nil, ErrAccessDenied
	}

	chat, err := s.chatRepo.GetUserChatByID(ctx, chatID, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get chat: %w", err)
	}

	if chat == nil {
		return nil, nil
	}

	s.decryptChatList([]*models.ChatListItem{chat})

	return chat, nil
}

func (s *ChatService) GetGroupChatBase(ctx context.Context, chatID string,) (*models.ChatListItem, error) {
    if chatID == "" {
        return nil, fmt.Errorf("chat ID is required")
    }

    chat, err := s.chatRepo.GetGroupChatBase(ctx, chatID)
    if err != nil {
        return nil, fmt.Errorf("failed to get group chat base: %w", err)
    }
    if chat == nil {
        return nil, nil
    }

    s.decryptChatList([]*models.ChatListItem{chat})
    return chat, nil
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

	chats, err := s.chatRepo.SearchChatByNickname(ctx, query, currentUserID, limit, offset)
	if err != nil {
		return nil, fmt.Errorf("failed to search chats: %w", err)
	}

	s.decryptChatList(chats)

	return chats, nil
}

func (s *ChatService) GeneratePrivateChatID(user1ID, user2ID string) string {
	if user1ID < user2ID {
		return "private_" + user1ID + "_" + user2ID
	}
	return "private_" + user2ID + "_" + user1ID
}

func (s *ChatService) GenerateGroupChatID() string {
	return "group_" + uuid.New().String()
}

func (s *ChatService) IsPrivateChat(chatID string) bool {
	return strings.HasPrefix(chatID, "private_")
}

func (s *ChatService) ExtractUsersFromChatID(chatID string) (string, string, error) {
	if !s.IsPrivateChat(chatID) {
		return "", "", fmt.Errorf("invalid chat ID format: must start with 'private_'")
	}

	usersPart := strings.TrimPrefix(chatID, "private_")
	parts := strings.Split(usersPart, "_")

	if len(parts) != 2 {
		return "", "", fmt.Errorf("invalid chat ID format: expected 2 user IDs")
	}

	if parts[0] == "" || parts[1] == "" {
		return "", "", fmt.Errorf("invalid chat ID format: user IDs cannot be empty")
	}

	return parts[0], parts[1], nil
}

func (s *ChatService) GetOtherUserID(chatID, currentUserID string) (string, error) {
	if !s.IsPrivateChat(chatID) {
		return "", fmt.Errorf("chat is not private")
	}

	user1ID, user2ID, err := s.ExtractUsersFromChatID(chatID)
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

func (s *ChatService) IsUserInDialog(ctx context.Context, chatID, userID string) (bool, error) {
	if s.IsPrivateChat(chatID) {
		user1, user2, err := s.ExtractUsersFromChatID(chatID)
		if err != nil {
			return false, fmt.Errorf("invalid chat ID: %w", err)
		}
		return userID == user1 || userID == user2, nil
	}

	isMember, err := s.chatRepo.IsGroupMember(ctx, chatID, userID)
	if err != nil {
		return false, fmt.Errorf("failed to check group membership: %w", err)
	}

	return isMember, nil
}

func (s *ChatService) EnsureChatMembers(ctx context.Context, chatID string, userIDs []string) error {
    if len(userIDs) == 0 {
        return nil
    }
    return s.chatRepo.EnsureChatMembers(ctx, chatID, userIDs)
}

func (s *ChatService) DecryptForUser(encryptedText string) (string, error) {
	if encryptedText == "" {
		return "", nil
	}

	userText, err := s.cryptoService.DecryptMessage(encryptedText)
	if err != nil {
		return "", err
	}

	return string(userText), nil
}

func (s *ChatService) decryptChatList(chats []*models.ChatListItem) {
	for i, chat := range chats {
		if chat.LastMessage == nil || chat.LastMessage.MessageText == "" {
			continue
		}
		
		userText, err := s.DecryptForUser(chat.LastMessage.MessageText)
		if err != nil {
			chats[i].LastMessage.MessageText = "[encrypted]"
			continue
		}
		chats[i].LastMessage.MessageText = userText
	}
}


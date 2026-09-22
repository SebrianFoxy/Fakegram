package services

import (
	"context"
	"errors"
	"fmt"
	"log"
	"sort"
	"time"

	"fakegram-api/internal/models"
)

var (
    ErrMessageNotFound = errors.New("message not found")
    ErrAccessDenied    = errors.New("access denied")
    ErrInvalidMessage  = errors.New("invalid message")
    ErrNotGroupMember  = errors.New("user is not a member of this group")
)

type MessageService struct {
    messageRepo          MessageRepository
    userRepo             UserRepository
    chatRepo             ChatRepository
    messageNotifier      MessageNotifier 
    chatNotifier         ChatNotifier
    cryptoService        CryptoService
    chatService          *ChatService
}

func NewMessageService(
    messageRepo MessageRepository,
    userRepo UserRepository,
    chatRepo ChatRepository,
    messageNotifier MessageNotifier,
    chatNotifier ChatNotifier,
    cryptoService CryptoService,
    chatService *ChatService,
) *MessageService {
    return &MessageService{
        messageRepo:          messageRepo,
        userRepo:             userRepo,
        chatRepo:             chatRepo,
        messageNotifier:      messageNotifier,
        chatNotifier:         chatNotifier,
        cryptoService:        cryptoService,    
        chatService:          chatService,
    }
}

func (s *MessageService) SetNotifier(messageNotifier MessageNotifier, chatNotifier ChatNotifier) {
	s.messageNotifier = messageNotifier
    s.chatNotifier = chatNotifier
}

func (s *MessageService) SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.MessageDetail, error) {
    chatID, receiverID, err := s.resolveChatAndReceiver(ctx, senderID, req)
	if err != nil {
		return nil, err
	}

	if receiverID != "" {
        if err := s.chatService.EnsureChatMembers(
            ctx, chatID, []string{senderID, receiverID},
        ); err != nil {
            return nil, fmt.Errorf("ensure private chat members: %w", err)
        }
    }

    if err := s.validateReply(ctx, chatID, senderID, req.ReplyToMessageID); err != nil {
		return nil, err
	}

    encryptedText, err := s.encryptForUser(req.MessageText)
	if err != nil {
		return nil, fmt.Errorf("failed to encrypt message: %w", err)
	}

    createReq := &models.CreateMessageRequest{
        ChatID:           chatID,
        MessageText:      encryptedText,
        MessageType:      req.MessageType,
        ReplyToMessageID: req.ReplyToMessageID,
    }

    messageID, err := s.messageRepo.CreateMessage(ctx, chatID, senderID, createReq)
	if err != nil {
		return nil, fmt.Errorf("failed to create message: %w", err)
	}
    
    messageDetail, err := s.messageRepo.GetMessageDetailByID(ctx, messageID, senderID)
	if err != nil {
		return nil, fmt.Errorf("failed to get message detail: %w", err)
	}

    messageDetail = s.decryptMessageDetail(messageDetail)

	s.chatNotifier.SubscribeToChat(senderID, chatID)

    if receiverID != "" {
		s.chatNotifier.SubscribeToChat(receiverID, chatID)
		s.messageNotifier.NotifyNewMessage(receiverID, messageDetail, chatID, senderID)
	} else {
		s.messageNotifier.NotifyNewMessage("", messageDetail, chatID, senderID)
	}

	s.messageNotifier.NotifyMessageSent(senderID, messageDetail, chatID, receiverID)
	s.updateChatListForParticipants(chatID, senderID)

    log.Printf("Message sent by user %s in chat %s", 
        senderID, chatID)
    
    return messageDetail, nil
}

func (s *MessageService) GetMessagesByChat(ctx context.Context, userID, chatID string, cursor *time.Time, limit int, direction string) (*models.GetMessagesResponse, error) {
    if userID == "" || chatID == "" {
		return nil, fmt.Errorf("user ID and chat ID are required")
	}
    
    if limit <= 0 || limit > 100 {
        limit = 30
    }
    
    if direction != "around" && direction != "older" && direction != "newer" {
        return nil, fmt.Errorf("invalid direction: %s", direction)
    }

    if (direction == "older" || direction == "newer") && cursor == nil {
        return nil, fmt.Errorf("cursor is required for direction: %s", direction)
    }
    
    isMember, err := s.chatService.IsUserInDialog(ctx, chatID, userID)
    if err != nil {
        return nil, fmt.Errorf("failed to check user membership: %w", err)
    }
    if !isMember {
        return nil, ErrAccessDenied
    }
    
	var messages []*models.MessageDetail
	var hasMoreOlder, hasMoreNewer bool

	switch direction {
	case "around":
		messages, hasMoreOlder, hasMoreNewer, err = s.getInitialMessages(ctx, userID, chatID, cursor, limit)
	case "older":
		messages, hasMoreOlder, hasMoreNewer, err = s.getOlderMessages(ctx, userID, chatID, *cursor, limit)
	case "newer":
		messages, hasMoreOlder, hasMoreNewer, err = s.getNewerMessages(ctx, userID, chatID, *cursor, limit)
	}

	if err != nil {
		return nil, fmt.Errorf("failed to get messages: %w", err)
	}

    for i, msg := range messages {
		messages[i] = s.decryptMessageDetail(msg)
	}
    
    response := &models.GetMessagesResponse{
        Messages:      messages,
        Count:         len(messages),
        TotalUnread:   0,
        HasMoreOlder:  hasMoreOlder,
        HasMoreNewer:  hasMoreNewer,
    }
    
    if len(messages) > 0 {
        if direction == "newer" {
            firstMsgTime := messages[0].CreatedAt
            lastMsgTime := messages[len(messages)-1].CreatedAt
            response.FirstMsgTime = &firstMsgTime
            response.LastMsgTime = &lastMsgTime
            
            response.Cursors = &models.MessageCursors{}
            if hasMoreOlder {
                response.Cursors.Older = &firstMsgTime
            }
            if hasMoreNewer {
                response.Cursors.Newer = &lastMsgTime
            }
        } else {
            firstMsgTime := messages[len(messages)-1].CreatedAt
            lastMsgTime := messages[0].CreatedAt
            response.FirstMsgTime = &firstMsgTime
            response.LastMsgTime = &lastMsgTime
            
            response.Cursors = &models.MessageCursors{}
            if hasMoreOlder {
                response.Cursors.Older = &firstMsgTime
            }
            if hasMoreNewer {
                response.Cursors.Newer = &lastMsgTime
            }
        }
    }
    
    return response, nil
}

func (s *MessageService) DeleteMessage(ctx context.Context, userID, messageID string) error {
    messageDetail, err := s.messageRepo.GetMessageDetailByID(ctx, messageID, userID)
    if err != nil {
        if err.Error() == "message not found" {
            return ErrMessageNotFound
        }
        return fmt.Errorf("failed to get message details: %w", err)
    }
    
    if messageDetail.SenderID != userID {
        return ErrAccessDenied
    }

    isMember, err := s.chatService.IsUserInDialog(ctx, messageDetail.ChatID, userID)
	if err != nil {
		return fmt.Errorf("failed to check user membership: %w", err)
	}
	if !isMember {
		return ErrAccessDenied
	}
    
    if err := s.messageRepo.DeleteMessage(ctx, userID, messageDetail.ChatID, messageID); err != nil {
        return fmt.Errorf("failed to delete message: %w", err)
    }

    s.messageNotifier.NotifyMessageDeleted(messageDetail.ChatID, messageID, userID)
    s.updateChatListForParticipants(messageDetail.ChatID, userID)
    
    log.Printf("Message %s deleted by user %s in chat %s", messageID, userID, messageDetail.ChatID)
    return nil
}

func (s *MessageService) EditMessage(ctx context.Context, userID, messageID string, req *models.UpdateMessageRequest) (*models.MessageDetail, error) {
    message, err := s.messageRepo.GetMessageDetailByID(ctx, messageID, userID)
    if err != nil {
        return nil, fmt.Errorf("failed to get message: %w", err)
    }
    if message == nil {
        return nil, ErrMessageNotFound
    }

    isMember, err := s.chatService.IsUserInDialog(ctx, message.ChatID, userID)
    if err != nil {
        return nil, fmt.Errorf("failed to check user membership: %w", err)
    }
    if !isMember {
        return nil, ErrAccessDenied
    }

    if message.SenderID != userID {
        return nil, ErrAccessDenied
    }

    if message.IsDeleted {
        return nil, fmt.Errorf("cannot edit a deleted message")
    }

    if time.Since(message.CreatedAt) > 24*time.Hour {
        return nil, fmt.Errorf("cannot edit message after 24 hours of creation")
    }

    encryptedText, err := s.encryptForUser(req.MessageText)
	if err != nil {
		return nil, fmt.Errorf("failed to encrypt message: %w", err)
	}
	req.MessageText = encryptedText

    updatedMessage, err := s.messageRepo.EditMessage(ctx, messageID, req.MessageText)
    if err != nil {
        if errors.Is(err, models.ErrMessageNotFound) {
            return nil, ErrMessageNotFound
        }
        return nil, fmt.Errorf("failed to edit message: %w", err)
    }

    messageDetail := &models.MessageDetail{
        Message:  updatedMessage,
        IsRead:   message.IsRead,
        ReadAt:   message.ReadAt,
        Sender:   message.Sender,
        ReplyToMessage: message.ReplyToMessage,
    }

    messageDetail = s.decryptMessageDetail(messageDetail)

    s.messageNotifier.NotifyMessageEdited(message.ChatID, messageDetail, userID)
    s.updateChatListForParticipants(messageDetail.ChatID, userID)

    log.Printf("Message %s edited by user %s in chat %s", messageID, userID, message.ChatID)
    return messageDetail, nil
}

func (s *MessageService) MarkAllAsRead(ctx context.Context, userID, chatID string) error {
	isMember, err := s.chatService.IsUserInDialog(ctx, chatID, userID)
	if err != nil {
		return fmt.Errorf("failed to check user membership: %w", err)
	}
	if !isMember {
		return ErrAccessDenied
	}

	unreadCount, err := s.messageRepo.GetUnreadCount(ctx, chatID, userID)
	if err != nil {
		return fmt.Errorf("failed to check unread count: %w", err)
	}

	if unreadCount == 0 {
		log.Printf("No unread messages for user %s in chat %s", userID, chatID)
		return nil
	}

	lastMessage, err := s.messageRepo.GetLastMessageFromOthersUser(ctx, chatID, userID)
	if err != nil {
		return fmt.Errorf("failed to get last message: %w", err)
	}

	if lastMessage == nil {
		log.Printf("No messages from other users in chat %s", chatID)
		return nil
	}

	if err := s.messageRepo.MarkMessageAsRead(ctx, lastMessage.ID, userID, time.Now()); err != nil {
		return fmt.Errorf("failed to mark message as read: %w", err)
	}

	s.messageNotifier.NotifyMessageReadAll(userID, chatID)
	s.messageNotifier.NotifyUnreadCountUpdate(userID, chatID, 0)

	log.Printf("User %s marked all messages as read in chat %s", userID, chatID)
	return nil
}

func (s *MessageService) MarkAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error {
    isMember, err := s.chatService.IsUserInDialog(ctx, chatID, userID)
	if err != nil {
		return fmt.Errorf("failed to check user membership: %w", err)
	}
	if !isMember {
		return ErrAccessDenied
	}
    
	if err := s.messageRepo.MarkMessageAsRead(ctx, lastReadMessageID, userID, time.Now()); err != nil {
		return fmt.Errorf("failed to mark messages as read: %w", err)
	}

	s.messageNotifier.NotifyMessageRead(userID, chatID, lastReadMessageID)

	unreadCount, _ := s.messageRepo.GetUnreadCount(ctx, chatID, userID)
	s.messageNotifier.NotifyUnreadCountUpdate(userID, chatID, unreadCount)

	log.Printf("User %s marked messages up to %s as read in chat %s, remaining unread: %d",
		userID, lastReadMessageID, chatID, unreadCount)

	return nil
}

func (s *MessageService) updateChatListForParticipants(chatID string, excludeUserID string) {
	ctx := context.Background()
	
	if s.chatService.IsPrivateChat(chatID) {
		s.updatePrivateChatList(ctx, chatID, excludeUserID)
	} else {
		s.updateGroupChatList(ctx, chatID, excludeUserID)
	}
}

func (s *MessageService) updatePrivateChatList(ctx context.Context, chatID string, excludeUserID string) {
	user1, user2, err := s.chatService.ExtractUsersFromChatID(chatID)
	if err != nil {
		log.Printf("Error extracting users: %v", err)
		return
	}
	
	participants := []string{user1, user2}
	
	for _, participantID := range participants {
		if participantID == excludeUserID {
			continue
		}
		
		chat, err := s.chatService.GetChatByID(ctx, chatID, participantID)
		if err != nil {
            log.Printf("get chat %s for user %s: %v", chatID, participantID, err)
            continue
        }

        if chat == nil {
            s.chatNotifier.NotifyChatDeleted(chatID, participantID)
            continue
        }

        s.chatNotifier.NotifyChatListUpdate(chatID, chat, participantID)
	}
}

func (s *MessageService) updateGroupChatList(ctx context.Context, chatID string, senderID string) {
	base, err := s.chatService.GetGroupChatBase(ctx, chatID)
    if err != nil {
        log.Printf("get group chat base %s: %v", chatID, err)
        return
    }
    if base == nil {
        s.chatNotifier.NotifyChatDeleted(chatID, senderID)
        return
    }

    unread, err := s.messageRepo.GetUnreadCountsForChat(ctx, chatID)
    if err != nil {
        log.Printf("get unread counts %s: %v", chatID, err)
        return
    }

    for userID, count := range unread {
        if userID == senderID {
            continue
        }
        item := cloneChatListItem(base)
        item.UnreadCount = count
        s.chatNotifier.NotifyChatListUpdate(chatID, item, userID)
    }
}

func (s *MessageService) encryptForUser(userText string) (string, error) {
	if userText == "" {
		return "", nil
	}

	return s.cryptoService.EncryptMessage(userText)
}

func (s *MessageService) decryptMessageDetail(msg *models.MessageDetail) *models.MessageDetail {
	if msg == nil {
		return nil
	}

	if msg.MessageText != "" {
		userText, err := s.chatService.DecryptForUser(msg.MessageText)
		if err == nil {
			msg.MessageText = userText
		} else {
			msg.MessageText = "[encrypted]"
		}
	}

	if msg.ReplyToMessage != nil && msg.ReplyToMessage.MessageText != "" {
		userText, err := s.chatService.DecryptForUser(msg.ReplyToMessage.MessageText)
		if err == nil {
			msg.ReplyToMessage.MessageText = userText
		} else {
			msg.ReplyToMessage.MessageText = "[encrypted]"
		}
	}

	return msg
}

func (s *MessageService) getInitialMessages(ctx context.Context, userID, chatID string, cursor *time.Time, limit int) ([]*models.MessageDetail, bool, bool, error) {
	var anchorTime time.Time

	if cursor != nil {
		anchorTime = *cursor
		log.Printf("DEBUG getInitialMessages: using provided cursor time: %v", anchorTime)
	} else {
		lastReadTime, err := s.messageRepo.GetLastReadTime(ctx, chatID, userID)
		if err != nil {
			return nil, false, false, fmt.Errorf("failed to get last read time: %w", err)
		}

		baseTime := time.Time{}
		if lastReadTime != nil {
			baseTime = *lastReadTime
		}

		firstUnreadTime, err := s.messageRepo.GetFirstUnreadTime(ctx, chatID, userID, baseTime)
		if err != nil {
			return nil, false, false, fmt.Errorf("failed to get first unread: %w", err)
		}

		if firstUnreadTime != nil {
			anchorTime = *firstUnreadTime
		} else {
			lastUserMessageTime, err := s.messageRepo.GetLastUserMessageTime(ctx, chatID, userID)
			if err != nil {
				return nil, false, false, fmt.Errorf("failed to get last user message time: %w", err)
			}

			if lastUserMessageTime != nil && lastUserMessageTime.After(baseTime) {
				anchorTime = *lastUserMessageTime
			} else if lastReadTime != nil {
				anchorTime = *lastReadTime
			} else {
				lastMessageTime, err := s.messageRepo.GetLastMessageTime(ctx, chatID)
				if err != nil {
					return nil, false, false, fmt.Errorf("failed to get last message time: %w", err)
				}
				if lastMessageTime != nil {
					anchorTime = *lastMessageTime
				} else {
					return []*models.MessageDetail{}, false, false, nil
				}
			}
		}
	}

	beforeLimit := limit / 2
	afterLimit := limit - beforeLimit

	olderMessages, err := s.messageRepo.GetMessagesByTimeRange(ctx, chatID, userID, anchorTime, beforeLimit, "older")
	if err != nil {
		return nil, false, false, err
	}

	newerMessages, err := s.messageRepo.GetMessagesByTimeRange(ctx, chatID, userID, anchorTime, afterLimit, "newer")
	if err != nil {
		return nil, false, false, err
	}

	allMessages := append(olderMessages, newerMessages...)
	
	sort.Slice(allMessages, func(i, j int) bool {
		return allMessages[i].CreatedAt.Before(allMessages[j].CreatedAt)
	})

	hasMoreOlder := false
	if len(olderMessages) > 0 {
		oldestTime := olderMessages[0].CreatedAt
		hasMoreOlder, _ = s.messageRepo.HasOlderMessages(ctx, chatID, oldestTime)
	}

	hasMoreNewer := false
	if len(newerMessages) > 0 {
		newestTime := newerMessages[len(newerMessages)-1].CreatedAt
		hasMoreNewer, _ = s.messageRepo.HasNewerMessages(ctx, chatID, newestTime)
	} else if len(olderMessages) > 0 && !hasMoreOlder {
		hasMoreNewer, _ = s.messageRepo.HasNewerMessages(ctx, chatID, anchorTime)
	}

    if len(allMessages) == 0 {
		allMessages = make([]*models.MessageDetail, 0)
	}

	return allMessages, hasMoreOlder, hasMoreNewer, nil
}

func (s *MessageService) getOlderMessages(ctx context.Context, userID, chatID string, cursor time.Time, limit int) ([]*models.MessageDetail, bool, bool, error) {
	messages, err := s.messageRepo.GetMessagesByTimeRange(ctx, chatID, userID, cursor, limit, "older")
	if err != nil {
		return nil, false, false, fmt.Errorf("failed to get older messages: %w", err)
	}

	hasMoreOlder := false
	if len(messages) > 0 {
		oldestTime := messages[0].CreatedAt
		hasMoreOlder, _ = s.messageRepo.HasOlderMessages(ctx, chatID, oldestTime)
	}

	if messages == nil {
		messages = make([]*models.MessageDetail, 0)
	}

	return messages, hasMoreOlder, true, nil
}

func (s *MessageService) getNewerMessages(ctx context.Context, userID, chatID string, cursor time.Time, limit int) ([]*models.MessageDetail, bool, bool, error) {
	messages, err := s.messageRepo.GetMessagesByTimeRange(ctx, chatID, userID, cursor, limit, "newer")
	if err != nil {
		return nil, false, false, fmt.Errorf("failed to get newer messages: %w", err)
	}

	hasMoreNewer := false
	if len(messages) > 0 {
		newestTime := messages[len(messages)-1].CreatedAt
		hasMoreNewer, _ = s.messageRepo.HasNewerMessages(ctx, chatID, newestTime)
	}

	if messages == nil {
		messages = make([]*models.MessageDetail, 0)
	}

	return messages, true, hasMoreNewer, nil
}

func (s *MessageService) resolveChatAndReceiver(ctx context.Context, senderID string, req *models.CreateMessageRequest) (string, string, error) {
	var chatID string
	var receiverID string

	if req.ChatID != "" {
		chatID = req.ChatID

		if s.chatService.IsPrivateChat(chatID) {
			otherUserID, err := s.chatService.GetOtherUserID(chatID, senderID)
			if err != nil {
				return "", "", ErrAccessDenied
			}
			receiverID = otherUserID

			approved, err := s.userRepo.CheckUsersApproved(ctx, senderID, receiverID)
			if err != nil {
				return "", "", fmt.Errorf("failed to verify users: %w", err)
			}
			if !approved {
				return "", "", fmt.Errorf("one or both users are not approved")
			}
		} else {
			isMember, err := s.chatService.IsUserInDialog(ctx, chatID, senderID)
			if err != nil {
				return "", "", fmt.Errorf("failed to check group membership: %w", err)
			}
			if !isMember {
				return "", "", ErrNotGroupMember
			}
		}
	} else if req.ReceiverID != "" {
		if senderID == req.ReceiverID {
			return "", "", fmt.Errorf("cannot send message to yourself")
		}
		receiverID = req.ReceiverID
		chatID = s.chatService.GeneratePrivateChatID(senderID, receiverID)

		approved, err := s.userRepo.CheckUsersApproved(ctx, senderID, receiverID)
		if err != nil {
			return "", "", fmt.Errorf("failed to verify users: %w", err)
		}
		if !approved {
			return "", "", fmt.Errorf("one or both users are not approved")
		}
	} else {
		return "", "", fmt.Errorf("either chat_id or receiver_id must be provided")
	}

	return chatID, receiverID, nil
}

func (s *MessageService) validateReply(ctx context.Context, chatID, senderID string, replyToMessageID *string) error {
	if replyToMessageID == nil || *replyToMessageID == "" {
		return nil
	}

	replyMsg, err := s.messageRepo.GetMessageDetailByID(ctx, *replyToMessageID, senderID)
	if err != nil {
		if errors.Is(err, models.ErrMessageNotFound) {
			return fmt.Errorf("reply message not found")
		}
		return fmt.Errorf("failed to get reply message: %w", err)
	}

	if replyMsg.IsDeleted {
		return fmt.Errorf("cannot reply to a deleted message")
	}

	if replyMsg.ChatID != chatID {
		return fmt.Errorf("cannot reply to a message from another chat")
	}

	return nil
}

func cloneChatListItem(base *models.ChatListItem) *models.ChatListItem {
    if base == nil {
        return nil
    }
    item := *base  

    if base.OtherUser != nil {
        ou := *base.OtherUser
        item.OtherUser = &ou
    }
    return &item
}
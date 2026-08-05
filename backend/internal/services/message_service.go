package services

import (
	"context"
	"time"
	"errors"
	"fmt"
	"log"

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
    chatRepo             ChatRepository
    messageNotifier      MessageNotifier 
    chatNotifier         ChatNotifier
    cryptoService        CryptoService
}

func NewMessageService(
    messageRepo MessageRepository,
    chatRepo ChatRepository,
    messageNotifier MessageNotifier,
    chatNotifier ChatNotifier,
    cryptoService CryptoService,
) *MessageService {
    return &MessageService{
        messageRepo:          messageRepo,
        chatRepo:             chatRepo,
        messageNotifier:      messageNotifier,
        chatNotifier:         chatNotifier,
        cryptoService:        cryptoService,    
    }
}

func (s *MessageService) SetNotifier(messageNotifier MessageNotifier, chatNotifier ChatNotifier) {
	s.messageNotifier = messageNotifier
    s.chatNotifier = chatNotifier
}

func (s *MessageService) SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.MessageDetail, error) {
    var chatID string
    
    if req.ChatID != "" {
        chatID = req.ChatID
        
        isGroup := !models.IsPrivateChat(chatID)
        
        if isGroup {
            isMember, err := s.chatRepo.IsUserInDialog(ctx, chatID, senderID)
            if err != nil {
                return nil, fmt.Errorf("failed to check group membership: %w", err)
            }
            if !isMember {
                return nil, ErrNotGroupMember
            }
            
            req.ReceiverID = ""
        } else {
            isMember, err := s.chatRepo.IsUserInDialog(ctx, chatID, senderID)
            if err != nil {
                return nil, fmt.Errorf("failed to check user membership: %w", err)
            }
            if !isMember {
                return nil, ErrAccessDenied
            }

            user1, user2, err := getChatUsers(chatID)
            if err != nil {
                log.Printf("SendMessage error")
                return nil, err
            }

            if senderID != user1 && senderID != user2 {
                return nil, fmt.Errorf("sender %s is not a participant in chat %s", senderID, chatID)
            }

            if user1 == senderID {
                req.ReceiverID = user2
            } else {
                req.ReceiverID = user1
            }
        }
    } else if req.ReceiverID != "" {
        if senderID == req.ReceiverID {
            return nil, fmt.Errorf("cannot send message to yourself")
        }
        chatID = models.GenerateChatID(senderID, req.ReceiverID)
    } else {
        return nil, fmt.Errorf("either chat_id or receiver_id must be provided")
    }

    encryptedText, err := s.encryptForUser(req.MessageText)
	if err != nil {
		return nil, fmt.Errorf("failed to encrypt message: %w", err)
	}
	req.MessageText = encryptedText

    replyToMessageID := req.ReplyToMessageID
    if replyToMessageID != nil && *replyToMessageID == "" {
        replyToMessageID = nil
    }

    createReq := &models.CreateMessageRequest{
        ChatID:           chatID,
        MessageText:      req.MessageText,
        MessageType:      req.MessageType,
        ReplyToMessageID: replyToMessageID,
    }

    var message *models.MessageDetail
    
    if models.IsPrivateChat(chatID) {
        message, err = s.messageRepo.CreatePrivateMessage(ctx, senderID, req.ReceiverID, createReq)
    } else {
        //message, err = s.messageRepo.CreateGroupMessage(ctx, senderID, chatID, createReq)
    }
    
    if err != nil {
        return nil, fmt.Errorf("failed to create message: %w", err)
    }

    message = s.decryptMessageDetail(message)

    s.chatNotifier.SubscribeToChat(senderID, chatID)
    s.chatNotifier.SubscribeToChat(req.ReceiverID, chatID)
    
    s.messageNotifier.NotifyNewMessage(req.ReceiverID, message, chatID, senderID)
    s.messageNotifier.NotifyMessageSent(senderID, message, chatID, req.ReceiverID)
    s.updateChatListForParticipants(chatID, senderID)

    log.Printf("Message sent by user %s in chat %s (type: %s)", 
        senderID, chatID, getChatType(chatID))
    
    return message, nil
}

func (s *MessageService) GetMessagesByChat(ctx context.Context, userID, otherUserID string, cursor *time.Time, limit int, direction string) (*models.GetMessagesResponse, error) {
    if userID == otherUserID {
        return nil, fmt.Errorf("cannot get messages with yourself")
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
    
    chatID := models.GenerateChatID(userID, otherUserID)
    
    isMember, err := s.chatRepo.IsUserInDialog(ctx, chatID, userID)
    if err != nil {
        return nil, fmt.Errorf("failed to check user membership: %w", err)
    }
    if !isMember {
        return nil, ErrAccessDenied
    }
    
    messages, hasMoreOlder, hasMoreNewer, unreadCount, err := s.messageRepo.GetMessagesByChat(
        ctx, 
        userID, 
        otherUserID, 
        cursor, 
        limit, 
        direction,
    )
    if err != nil {
        return nil, fmt.Errorf("failed to get messages: %w", err)
    }

    for i, msg := range messages {
		messages[i] = s.decryptMessageDetail(msg)
	}
    
    response := &models.GetMessagesResponse{
        Messages:      messages,
        Count:         len(messages),
        TotalUnread:   unreadCount,
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

    user1, user2, err := getChatUsers(message.ChatID)
    if err != nil {
        log.Printf("EditMessage error")
        return nil, err
    }
    
    if userID != user1 && userID != user2 {
        return nil, ErrAccessDenied
    }

    isMember, err := s.chatRepo.IsUserInDialog(ctx, message.ChatID, userID)
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
	if err := s.messageRepo.MarkAllMessagesAsReadInChat(ctx, userID, chatID); err != nil {
		return fmt.Errorf("failed to mark all messages as read: %w", err)
	}

	user1, user2, err := getChatUsers(chatID)
    if err != nil {
        log.Printf("MarkAllAsRead error")
        return err
    }

	var otherUserID string
	if user1 == userID {
		otherUserID = user2
	} else {
		otherUserID = user1
	}

	s.messageNotifier.NotifyMessageReadAll(otherUserID, userID, chatID)
	s.messageNotifier.NotifyUnreadCountUpdate(userID, chatID, 0)

	log.Printf("User %s marked all messages as read in chat %s", userID, chatID)

	return nil
}

func (s *MessageService) MarkAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error {
	if err := s.messageRepo.MarkMessagesAsRead(ctx, userID, chatID, lastReadMessageID); err != nil {
		return fmt.Errorf("failed to mark messages as read: %w", err)
	}

	user1, user2, err := getChatUsers(chatID)
    if err != nil {
        log.Printf("MarkAsRead error")
        return err
    }

	var otherUserID string
	if user1 == userID {
		otherUserID = user2
	} else {
		otherUserID = user1
	}

	s.messageNotifier.NotifyMessageRead(otherUserID, userID, chatID, lastReadMessageID)

	unreadCount, _ := s.messageRepo.GetUnreadCount(ctx, chatID, userID)
	s.messageNotifier.NotifyUnreadCountUpdate(userID, chatID, unreadCount)

	log.Printf("User %s marked messages up to %s as read in chat %s, remaining unread: %d",
		userID, lastReadMessageID, chatID, unreadCount)

	return nil
}

func (s *MessageService) updateChatListForParticipants(chatID string, excludeUserID string) {
    user1, user2, err := getChatUsers(chatID)
    if err != nil {
        log.Printf("updateChatListError")
        return
    }

    participants := []string{user1, user2}

    for _, participantID := range participants {
        if participantID == excludeUserID {
            log.Printf("🟡 Skipping WebSocket notification for excluded user: %s", participantID)
            continue
        }

        log.Printf("🟢 Sending WebSocket update to user: %s", participantID)

        chats, err := s.chatRepo.GetUserChats(context.Background(), participantID)
        if err != nil {
            log.Printf("Error getting user chats for notification: %v", err)
            continue
        }

        for i, chat := range chats {
            if chat.LastMessage == nil || chat.LastMessage.MessageText == "" {
                continue
            }

            userText, err := s.decryptForUser(chat.LastMessage.MessageText)
            if err != nil {
                chats[i].LastMessage.MessageText = "[encrypted]"
                continue
            }
            chats[i].LastMessage.MessageText = userText
        }

        var updatedChat *models.ChatListItem
        for _, chat := range chats {
            if chat.ID == chatID {
                updatedChat = chat
                break
            }
        }

        if updatedChat != nil {
            log.Printf("Chat update: %s from userId: %s", chatID, excludeUserID)
            s.chatNotifier.NotifyChatListUpdate(chatID, updatedChat, excludeUserID)
        } else {
            log.Printf("❌ Chat not found for user %s", participantID)
            s.chatNotifier.NotifyChatDeleted(chatID, participantID)
        }
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
		userText, err := s.decryptForUser(msg.MessageText)
		if err == nil {
			msg.MessageText = userText
		} else {
			msg.MessageText = "[encrypted]"
		}
	}

	if msg.ReplyToMessage != nil && msg.ReplyToMessage.MessageText != "" {
		userText, err := s.decryptForUser(msg.ReplyToMessage.MessageText)
		if err == nil {
			msg.ReplyToMessage.MessageText = userText
		} else {
			msg.ReplyToMessage.MessageText = "[encrypted]"
		}
	}

	return msg
}

func (s *MessageService) decryptForUser(encryptedText string) (string, error) {
	if encryptedText == "" {
		return "", nil
	}

	userText, err := s.cryptoService.DecryptMessage(encryptedText)
	if err != nil {
		return "", err
	}

	return string(userText), nil
}

func getChatType(chatID string) string {
    if models.IsPrivateChat(chatID) {
        return "private"
    }
    return "group"
}

func getChatUsers(chatID string) (string, string, error) {
    user1, user2, err := models.ExtractUsersFromChatID(chatID)
    if err != nil {
        log.Printf("Error extracting users from chat ID: %v", err)
        return "", "", err
    }
    return user1, user2, nil
}
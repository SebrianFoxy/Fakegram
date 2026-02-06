package services

import (
	"context"
	"time"
	// "encoding/json"
	"errors"
	"fmt"
	"log"

	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
)



var (
    ErrMessageNotFound = errors.New("message not found")
    ErrAccessDenied    = errors.New("access denied")
    ErrInvalidMessage  = errors.New("invalid message")
)

type MessageService struct {
    messageRepo *repositories.MessageRepository
    chatRepo    *repositories.ChatRepository
    wsPool      types.PoolInterface
}

func NewMessageService(
    messageRepo *repositories.MessageRepository,
    chatRepo *repositories.ChatRepository,
    wsPool types.PoolInterface,
) *MessageService {
    return &MessageService{
        messageRepo: messageRepo,
        chatRepo:    chatRepo,
        wsPool:      wsPool,
    }
}

func (s *MessageService) SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.MessageDetail, error) {
    var chatID string
    
    if req.ChatID != "" {
        chatID = req.ChatID
        
        if !models.IsPrivateChat(chatID) {
            return nil, fmt.Errorf("invalid chat ID format")
        }
        
        isMember, err := s.chatRepo.IsUserInDialog(ctx, chatID, senderID)
        if err != nil {
            return nil, fmt.Errorf("failed to check user membership: %w", err)
        }
        if !isMember {
            return nil, ErrAccessDenied
        }

        user1, user2, err := models.ExtractUsersFromChatID(chatID)
        if err != nil {
            return nil, fmt.Errorf("failed to extract users from chat ID: %w", err)
        }

        if user1 != senderID && user2 != senderID {
            return nil, fmt.Errorf("sender %s is not a participant in chat %s", senderID, chatID)
        }

        if user1 == senderID {
            req.ReceiverID = user2
        } else {
            req.ReceiverID = user1
        }
    } else if req.ReceiverID != "" {
        if senderID == req.ReceiverID {
            return nil, fmt.Errorf("cannot send message to yourself")
        }
        chatID = models.GenerateChatID(senderID, req.ReceiverID)
    } else {
        return nil, fmt.Errorf("either chat_id or receiver_id must be provided")
    }

    replyToMessageID := req.ReplyToMessageID
    if replyToMessageID != nil && *replyToMessageID == "" {
        replyToMessageID = nil
    }

    createReq := &models.CreateMessageRequest{
        ChatID:           chatID,
        MessageText:      req.MessageText,
        MessageType:      req.MessageType,
        ReplyToMessageID: req.ReplyToMessageID,
    }

    message, err := s.messageRepo.CreatePrivateMessage(ctx, senderID, req.ReceiverID, createReq)
    if err != nil {
        return nil, fmt.Errorf("failed to create message: %w", err)
    }
    
    s.broadcastNewMessage(message)
    
    s.notifyReceiverAboutNewMessage(chatID, message, senderID)

    s.notifyChatParticipantsAboutNewMessage(chatID, message, senderID)
    
    log.Printf("Message sent by user %s in chat %s", senderID, chatID)
    return message, nil
}

func (s *MessageService) GetMessagesByChat(ctx context.Context, userID, otherUserID string, page, limit int) (*models.GetMessagesResponse, error) {
    if userID == otherUserID {
        return nil, fmt.Errorf("cannot get messages with yourself")
    }
    
    chatID := models.GenerateChatID(userID, otherUserID)
    
    isMember, err := s.chatRepo.IsUserInDialog(ctx, chatID, userID)
    if err != nil {
        return nil, fmt.Errorf("failed to check user membership: %w", err)
    }
    if !isMember {
        return nil, ErrAccessDenied
    }
    
    offset := (page - 1) * limit
    
    messages, totalCount, err := s.messageRepo.GetMessagesByChat(ctx, userID, otherUserID, limit, offset)
    if err != nil {
        return nil, fmt.Errorf("failed to get messages: %w", err)
    }
    
    response := models.ToGetMessagesResponse(messages, page, limit, totalCount)
    
    return response, nil
}

func (s *MessageService) broadcastNewMessage(message *models.MessageDetail) {
    event := types.WSEvent{
        Event: types.EventMessageSent,
        Data:  message,
    }

    s.wsPool.BroadcastToChat(message.ChatID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }, message.SenderID)
}

func (s *MessageService) notifyReceiverAboutNewMessage(chatID string, message *models.MessageDetail, senderID string) {
    if s.wsPool == nil {
        return
    }

    user1, user2, err := models.ExtractUsersFromChatID(chatID)
    if err != nil {
        log.Printf("Error extracting users from chat ID: %v", err)
        return
    }

    var receiverID string
    if user1 == senderID {
        receiverID = user2
    } else {
        receiverID = user1
    }

    log.Printf("🟢 Preparing message list update for receiver %s", receiverID)
    
    updateEvent := types.WSEvent{
        Event: types.EventMessageListUpdate,
        Data: map[string]interface{}{
            "action":      "new_message",
            "message":     message,
            "chat_id":     chatID,
            "sender_id":   senderID,
            "receiver_id": receiverID,
            "timestamp":   time.Now().Format(time.RFC3339),
        },
    }

    updateMessage := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(updateEvent),
    }

    if err := s.wsPool.SendToUser(receiverID, updateMessage); err != nil {
        log.Printf("❌ Failed to send message list update to user %s: %v", receiverID, err)
    } else {
        log.Printf("✅ Message list update sent to receiver %s", receiverID)
    }
    
    senderEvent := types.WSEvent{
        Event: types.EventMessageListUpdate,
        Data: map[string]interface{}{
            "action":      "new_message_sent",
            "message":     message,
            "chat_id":     chatID,
            "sender_id":   senderID,
            "receiver_id": receiverID,
            "timestamp":   time.Now().Format(time.RFC3339),
            "status":      "sent",
        },
    }
    
    senderMessage := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(senderEvent),
    }
    
    if err := s.wsPool.SendToUser(senderID, senderMessage); err != nil {
        log.Printf("❌ Failed to send sent confirmation to sender %s: %v", senderID, err)
    } else {
        log.Printf("✅ Sent confirmation sent to sender %s", senderID)
    }
}

func (s *MessageService) notifyChatParticipantsAboutNewMessage(chatID string, message *models.MessageDetail, excludeUserID string) {
    if s.wsPool == nil {
        return
    }

    user1, user2, err := models.ExtractUsersFromChatID(chatID)
    if err != nil {
        log.Printf("Error extracting users from chat ID: %v", err)
        return
    }

    participants := []string{user1, user2}

    log.Printf("🟢 Notifying participants about new message: %v, exclude: %s", participants, excludeUserID)

    for _, participantID := range participants {
        if participantID == excludeUserID {
            log.Printf("🟡 Skipping WebSocket notification for message sender: %s", participantID)
            continue
        }

        log.Printf("🟢 Sending WebSocket update to receiver: %s", participantID)

        chats, err := s.chatRepo.GetUserChats(context.Background(), participantID)
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
            s.wsPool.NotifyChatListUpdate(participantID, updatedChat)
        } else {
            log.Printf("❌ Chat not found for user %s", participantID)
        }
    }
}
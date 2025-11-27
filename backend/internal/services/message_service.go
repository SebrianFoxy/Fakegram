package services

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"

	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	message_websocket "fakegram-api/internal/websocket/messages"
)



var (
    ErrMessageNotFound = errors.New("message not found")
    ErrAccessDenied    = errors.New("access denied")
    ErrInvalidMessage  = errors.New("invalid message")
)

type MessageService struct {
    messageRepo *repositories.MessageRepository
    chatRepo    *repositories.ChatRepository
    wsPool      *message_websocket.Pool
}

func NewMessageService(
    messageRepo *repositories.MessageRepository,
    chatRepo *repositories.ChatRepository,
    wsPool *message_websocket.Pool,
) *MessageService {
    return &MessageService{
        messageRepo: messageRepo,
        chatRepo:    chatRepo,
        wsPool:      wsPool,
    }
}

func (s *MessageService) SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.Message, error) {
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
    } else if req.ReceiverID != "" {
        if senderID == req.ReceiverID {
            return nil, fmt.Errorf("cannot send message to yourself")
        }
        chatID = models.GenerateChatID(senderID, req.ReceiverID)
    } else {
        return nil, fmt.Errorf("either chat_id or receiver_id must be provided")
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

func (s *MessageService) broadcastNewMessage(message *models.Message) {
    event := message_websocket.WSEvent{
        Event: message_websocket.EventMessageSent,
        Data:  message,
    }

    s.wsPool.BroadcastToChat(message.ChatID, &message_websocket.Message{
        Type:    "event",
        Payload: mustMarshal(event),
    }, message.SenderID)
}

func mustMarshal(v interface{}) []byte {
    data, err := json.Marshal(v)
    if err != nil {
        log.Printf("Marshal error: %v", err)
        return []byte(`{"error": "marshal_failed"}`)
    }
    return data
}

func (s *MessageService) notifyChatParticipantsAboutNewMessage(chatID string, message *models.Message, excludeUserID string) {
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
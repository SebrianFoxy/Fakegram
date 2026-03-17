package events

import (
	"context"
	"encoding/json"
	"fakegram-api/internal/models"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
	"fmt"
	"log"
	"time"
)

type MessageHandlers struct {
    messageRepo *repositories.MessageRepository
    pool types.PoolInterface
}

func NewMessageHandlers(
    messageRepo *repositories.MessageRepository,
    pool types.PoolInterface,
    ) *MessageHandlers {
    return &MessageHandlers{
        messageRepo: messageRepo,
        pool: pool,
    }
}

func (h *MessageHandlers) HandleNewMessage(clientID string, payload json.RawMessage) error {
    var data struct {
        Message *models.Message `json:"message"`
        ChatID  string          `json:"chat_id"`
    }
    
    if err := utils.SafeUnmarshal(payload, &data); err != nil {
        return err
    }

    if data.Message == nil {
        log.Printf("Empty message in HandleNewMessage")
        return nil
    }

    user1, user2, err := models.ExtractUsersFromChatID(data.ChatID)
    if err != nil {
        log.Printf("Error extracting users: %v", err)
        return err
    }

    var receiverID string
    var senderID string
    if user1 == clientID {
        receiverID = user2
        senderID = user1
    } else {
        receiverID = user1
        senderID = user2
    }

    event := types.WSEvent{
        Event: types.EventMessageListUpdate,
        Data: map[string]interface{}{
            "message": data.Message,
            "chat_id": data.ChatID,
            "action":  "new_message",
            "sender_id": senderID,
        },
    }

    if err := h.pool.SendToUser(receiverID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }); err != nil {
        log.Printf("Failed to notify user %s about new message: %v", receiverID, err)
        return err
    }

    ctx := context.Background()
    unreadCount, err := h.messageRepo.GetUnreadCount(ctx, senderID, data.ChatID)
    if err != nil {
        log.Printf("Failed to get unread count for sender: %v", err)
    }

    receiptEvent := types.WSEvent{
        Event: types.EventMessageSent,
        Data: map[string]interface{}{
            "message_id":     data.Message.ID,
            "chat_id":        data.ChatID,
            "sent_at":        time.Now().Format(time.RFC3339),
            "unread_count":   unreadCount,
            "delivered_to":   receiverID,
        },
    }

    if err := h.pool.SendToUser(senderID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(receiptEvent),
    }); err != nil {
        log.Printf("Failed to send receipt to user %s: %v", senderID, err)
    }

    log.Printf("Notified user %s about new message in chat %s", receiverID, data.ChatID)
    return nil
}

func (h *MessageHandlers) HandleMessageRead(clientID string, payload json.RawMessage) error {
    var data struct {
        ChatID            string `json:"chat_id"`
        LastReadMessageID string `json:"last_read_message_id"`
    }
    
    if err := utils.SafeUnmarshal(payload, &data); err != nil {
        return fmt.Errorf("failed to unmarshal read receipt: %w", err)
    }

    if data.ChatID == "" {
        return fmt.Errorf("chat_id is required")
    }
    
    if data.LastReadMessageID == "" {
        return fmt.Errorf("last_read_message_id is required")
    }

    ctx := context.Background()
    err := h.messageRepo.MarkMessagesAsRead(ctx, clientID, data.ChatID, data.LastReadMessageID)
    if err != nil {
        return fmt.Errorf("failed to mark messages as read: %w", err)
    }

    unreadCount, err := h.messageRepo.GetUnreadCount(ctx, data.ChatID, clientID)
    if err != nil {
        log.Printf("Failed to get unread count: %v", err)
        unreadCount = 0
    }

    user1, user2, err := models.ExtractUsersFromChatID(data.ChatID)
    if err != nil {
        return fmt.Errorf("error extracting users: %w", err)
    }

    var otherUserID string
    if user1 == clientID {
        otherUserID = user2
    } else {
        otherUserID = user1
    }

    readReceiptEvent := types.WSEvent{
        Event: types.EventMessageRead,
        Data: map[string]interface{}{
            "user_id":            clientID,
            "chat_id":            data.ChatID,
            "last_read_message_id": data.LastReadMessageID,
            "read_at":            time.Now().Format(time.RFC3339),
        },
    }

    if err := h.pool.SendToUser(otherUserID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(readReceiptEvent),
    }); err != nil {
        log.Printf("Failed to notify user %s about read receipt: %v", otherUserID, err)
    }

    unreadEvent := types.WSEvent{
        Event: types.EventUnreadCountUpdate,
        Data: map[string]interface{}{
            "chat_id":      data.ChatID,
            "unread_count": unreadCount,
            "user_id":      clientID,
        },
    }

    if err := h.pool.SendToUser(clientID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(unreadEvent),
    }); err != nil {
        log.Printf("Failed to update unread count for user %s: %v", clientID, err)
    }

    log.Printf("User %s marked messages up to %s as read in chat %s, marked: %d, remaining unread: %d", 
        clientID, data.LastReadMessageID, data.ChatID, unreadCount)
    
    return nil
}

func (h *MessageHandlers) CreateMessageReadHandler() types.EventHandler {
    return types.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
        return h.HandleMessageRead(clientID, payload)
    })
}

func (h *MessageHandlers) CreateNewMessageHandler() types.EventHandler {
    return types.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
        return h.HandleNewMessage(clientID, payload)
    })
}
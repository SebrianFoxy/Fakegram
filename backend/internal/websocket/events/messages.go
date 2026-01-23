package events

import (
    "encoding/json"
    "fakegram-api/internal/models"
    "fakegram-api/internal/websocket/types"
    "fakegram-api/internal/websocket/utils"
    "log"
    "time"
)

type MessageHandlers struct {
    pool types.PoolInterface
}

func NewMessageHandlers(pool types.PoolInterface) *MessageHandlers {
    return &MessageHandlers{
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
    if user1 == clientID {
        receiverID = user2
    } else {
        receiverID = user1
    }

    event := types.WSEvent{
        Event: types.EventMessageListUpdate,
        Data: map[string]interface{}{
            "message": data.Message,
            "chat_id": data.ChatID,
            "action":  "new_message",
        },
    }

    if err := h.pool.SendToUser(receiverID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }); err != nil {
        log.Printf("Failed to notify user %s about new message: %v", receiverID, err)
        return err
    }

    log.Printf("Notified user %s about new message in chat %s", receiverID, data.ChatID)
    return nil
}

func (h *MessageHandlers) HandleMessageRead(clientID string, payload json.RawMessage) error {
    var data struct {
        ChatID     string   `json:"chat_id"`
        MessageIDs []string `json:"message_ids"`
    }
    
    if err := utils.SafeUnmarshal(payload, &data); err != nil {
        return err
    }

    if len(data.MessageIDs) == 0 {
        log.Printf("Empty message_ids list")
        return nil
    }

    user1, user2, err := models.ExtractUsersFromChatID(data.ChatID)
    if err != nil {
        log.Printf("Error extracting users: %v", err)
        return err
    }

    var otherUserID string
    if user1 == clientID {
        otherUserID = user2
    } else {
        otherUserID = user1
    }

    event := types.WSEvent{
        Event: types.EventMessageRead,
        Data: map[string]interface{}{
            "user_id":     clientID,
            "chat_id":     data.ChatID,
            "message_ids": data.MessageIDs,
            "read_at":     time.Now().Format(time.RFC3339),
        },
    }

    if err := h.pool.SendToUser(otherUserID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }); err != nil {
        log.Printf("Failed to notify user %s: %v", otherUserID, err)
    }

    log.Printf("Notified user %s about read messages", otherUserID)
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
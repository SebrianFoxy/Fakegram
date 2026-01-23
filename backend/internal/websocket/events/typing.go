package events

import (
    "encoding/json"
    "fakegram-api/internal/websocket/types"
    "fakegram-api/internal/websocket/utils"
    "log"
    "time"
)

type TypingHandlers struct {
    pool types.PoolInterface
}

func NewTypingHandlers(pool types.PoolInterface) *TypingHandlers {
    return &TypingHandlers{
        pool: pool,
    }
}

func (h *TypingHandlers) HandleTypingStart(clientID string, payload json.RawMessage) error {
    var data struct {
        ChatID string `json:"chat_id"`
    }
    
    if err := utils.SafeUnmarshal(payload, &data); err != nil {
        log.Printf("Error unmarshaling typing start: %v", err)
        return err
    }

    client := h.pool.GetClient(clientID)
    if client != nil {
        client.SetActiveChat(data.ChatID)
        client.SetLastTyping(time.Now().Unix())
    }

    event := types.WSEvent{
        Event: types.EventUserTyping,
        Data: map[string]interface{}{
            "user_id": clientID,
            "chat_id": data.ChatID,
            "typing":  true,
            "at":      time.Now(),
        },
    }

    h.pool.BroadcastToChat(data.ChatID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }, clientID)

    return nil
}

func (h *TypingHandlers) HandleTypingStop(clientID string, payload json.RawMessage) error {
    var data struct {
        ChatID string `json:"chat_id"`
    }
    
    if err := utils.SafeUnmarshal(payload, &data); err != nil {
        log.Printf("Error unmarshaling typing stop: %v", err)
        return err
    }

    event := types.WSEvent{
        Event: types.EventUserTyping,
        Data: map[string]interface{}{
            "user_id": clientID,
            "chat_id": data.ChatID,
            "typing":  false,
            "at":      time.Now(),
        },
    }

    h.pool.BroadcastToChat(data.ChatID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }, clientID)

    return nil
}

func (h *TypingHandlers) CreateTypingStartHandler() types.EventHandler {
    return types.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
        return h.HandleTypingStart(clientID, payload)
    })
}

func (h *TypingHandlers) CreateTypingStopHandler() types.EventHandler {
    return types.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
        return h.HandleTypingStop(clientID, payload)
    })
}
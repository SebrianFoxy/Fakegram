package pool

import (
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
	"log"
	"time"
)

func (p *Pool) broadcastMessage(message *types.Message) {
    p.mu.RLock()
    defer p.mu.RUnlock()

    for _, client := range p.Clients {
        if err := client.SendMessage(message); err != nil {
            log.Printf("Error broadcasting to client %s: %v", client.GetUserID(), err)
            client.Close()
        }
    }
}

func (p *Pool) BroadcastToChat(chatID string, message *types.Message, excludeUserID string) {
    p.mu.RLock()
    defer p.mu.RUnlock()

    for userID, client := range p.Clients {
        if userID == excludeUserID {
            continue
        }
        
        if err := client.SendMessage(message); err != nil {
            log.Printf("Error sending to user %s: %v", userID, err)
        }
    }
}

func (p *Pool) SendToUser(userID string, message *types.Message) error {
    p.mu.RLock()
    defer p.mu.RUnlock()

    client, exists := p.Clients[userID]
    if !exists {
        return &types.UserNotConnectedError{UserID: userID}
    }

    if err := client.SendMessage(message); err != nil {
        log.Printf("Error sending to user %s: %v", userID, err)
        
        go func() {
            p.Unregister <- client
            client.Close()
        }()
        
        return err
    }

    log.Printf("Message sent to user %s", userID)
    return nil
}

func (p *Pool) NotifyChatListUpdate(userID string, chat interface{}) {
    log.Printf("Preparing to send chat update to user %s", userID)

    event := types.WSEvent{
        Event: types.EventChatListUpdate,
        Data: map[string]interface{}{
            "chat":      chat,
            "timestamp": time.Now().Format(time.RFC3339),
        },
    }

    message := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }

    if err := p.SendToUser(userID, message); err != nil {
        log.Printf("Failed to send chat list update to user %s: %v", userID, err)
    } else {
        log.Printf("Chat list update sent to user %s", userID)
    }
}
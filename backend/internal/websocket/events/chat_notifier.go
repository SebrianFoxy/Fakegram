package events

import (
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
	"log"
	"time"
)

type ChatWsNotifier struct {
	pool PoolInterface
}

func NewChatWsNotifier(pool PoolInterface) *ChatWsNotifier {
	return &ChatWsNotifier{
		pool:     pool,
	}
}

func (n *ChatWsNotifier) SubscribeToChat(userID, chatID string) {
    client := n.pool.GetClient(userID)
    if client == nil {
        log.Printf("User %s is offline, will subscribe on connect", userID)
        return
    }
    
    if client.IsInChat(chatID) {
        log.Printf("User %s already in chat %s, skipping subscription", userID, chatID)
        return
    }
    
    client.JoinChat(chatID)
    log.Printf("✅ User %s subscribed to chat %s", userID, chatID)
}

func (n *ChatWsNotifier) NotifyChatListUpdate(chatID string, chat interface{}, excludeUserID string) {
    event := types.WSEvent{
        Event: types.EventChatListUpdate,
        Data: map[string]interface{}{
            "chat":      chat,
            "timestamp": time.Now().Format(time.RFC3339),
        },
    }

    
    n.broadcastToChat(chatID, event, excludeUserID)
}

func (n *ChatWsNotifier) NotifyChatDeleted(chatID string, userID string) {
    event := types.WSEvent{
		Event: types.EventChatDeleted,
		Data: map[string]interface{}{
			"chat_id":      chatID,
			"user_id":      userID,
		},
	}

	n.sendEvent(userID, event)
}

func (n *ChatWsNotifier) broadcastToChat(chatID string, event types.WSEvent, excludeUserID string) {
	message := &types.Message{
		Type:    "event",
		Payload: utils.MustMarshal(event),
	}

	n.pool.BroadcastToChat(chatID, message, excludeUserID)
}

func (n *ChatWsNotifier) sendEvent(userID string, event types.WSEvent) {
	message := &types.Message{
		Type:    "event",
		Payload: utils.MustMarshal(event),
	}

	if err := n.pool.SendToUser(userID, message); err != nil {
		log.Printf("Failed to send event to user %s: %v", userID, err)
	}
}
package events

import (
	"fakegram-api/internal/models"
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
	"log"
	"time"
)

type MessageWsNotifier struct {
	pool PoolInterface
}

func NewMessageWsNotifier(pool PoolInterface) *MessageWsNotifier {
	return &MessageWsNotifier{pool: pool}
}

func (n *MessageWsNotifier) NotifyNewMessage(receiverID string, message *models.MessageDetail, chatID, senderID string) {
	log.Printf("Preparing to send new message notification for chat %s", chatID)

	broadcastEvent := types.WSEvent{
		Event: types.EventMessageListUpdate,
		Data: map[string]interface{}{
			"action":    "new_message",
			"message":   message,
			"chat_id":   chatID,
			"sender_id": senderID,
			"receiver_id": receiverID,
			"timestamp": time.Now().Format(time.RFC3339),
		},
	}
	n.broadcastToChat(chatID, broadcastEvent, senderID)

	log.Printf("✅ New message broadcast to chat %s", chatID)
}



func (n *MessageWsNotifier) NotifyMessageSent(senderID string, message *models.MessageDetail, chatID, receiverID string) {
	log.Printf("Preparing to send message sent confirmation to user %s", senderID)

	event := types.WSEvent{
		Event: types.EventMessageSent,
		Data: map[string]interface{}{
			"action": 	   "new_message_sent",
			"message":     message,
			"chat_id":     chatID,
			"sender_id":   senderID,
			"receiver_id": receiverID,
			"status":      "sent",
			"timestamp":   time.Now().Format(time.RFC3339),
		},
	}

	n.sendEvent(senderID, event)
}

func (n *MessageWsNotifier) NotifyMessageRead(otherUserID, userID, chatID, lastReadMessageID string) {
	log.Printf("Preparing to send read receipt to user %s", otherUserID)

	event := types.WSEvent{
		Event: types.EventMessageRead,
		Data: map[string]interface{}{
			"user_id":              userID,
			"chat_id":              chatID,
			"last_read_message_id": lastReadMessageID,
			"read_at":              time.Now().Format(time.RFC3339),
		},
	}

	n.sendEvent(otherUserID, event)
}

func (n *MessageWsNotifier) NotifyMessageReadAll(otherUserID, userID, chatID string) {
	log.Printf("Preparing to send read all notification to user %s", otherUserID)

	event := types.WSEvent{
		Event: types.EventMessageReadAll,
		Data: map[string]interface{}{
			"user_id": userID,
			"chat_id": chatID,
			"read_at": time.Now().Format(time.RFC3339),
		},
	}

	n.sendEvent(otherUserID, event)
}

func (n *MessageWsNotifier) NotifyMessageDeleted(chatID, messageID, userID string) {
	event := types.WSEvent{
		Event: types.EventMessageListUpdate,
		Data: map[string]interface{}{
			"action":    "message_deleted",
			"message_id": messageID,
			"chat_id":    chatID,
			"deleted_by": userID,
			"deleted_at": time.Now().Format(time.RFC3339),
		},
	}
	n.broadcastToChat(chatID, event, userID)
	
	log.Printf("✅ Message %s deleted, broadcast to chat %s", messageID, chatID)
}

func (n *MessageWsNotifier) NotifyMessageEdited(chatID string, message *models.MessageDetail, editorID string) {
	event := types.WSEvent{
		Event: types.EventMessageListUpdate,
		Data: map[string]interface{}{
			"action":    "message_edited",
			"message":   message,
			"chat_id":   chatID,
			"edited_by": editorID,
			"edited_at": time.Now().Format(time.RFC3339),
		},
	}
	n.broadcastToChat(chatID, event, editorID)

	log.Printf("✅ Message %s edited, broadcast to chat %s", message.ID, chatID)
}

func (n *MessageWsNotifier) NotifyUnreadCountUpdate(userID, chatID string, unreadCount int) {
	event := types.WSEvent{
		Event: types.EventUnreadCountUpdate,
		Data: map[string]interface{}{
			"chat_id":      chatID,
			"unread_count": unreadCount,
			"user_id":      userID,
		},
	}

	n.sendEvent(userID, event)
}

func (n *MessageWsNotifier) sendEvent(userID string, event types.WSEvent) {
	message := &types.Message{
		Type:    "event",
		Payload: utils.MustMarshal(event),
	}

	if err := n.pool.SendToUser(userID, message); err != nil {
		log.Printf("Failed to send event to user %s: %v", userID, err)
	}
}

func (n *MessageWsNotifier) broadcastToChat(chatID string, event types.WSEvent, excludeUserID string) {
	message := &types.Message{
		Type:    "event",
		Payload: utils.MustMarshal(event),
	}

	n.pool.BroadcastToChat(chatID, message, excludeUserID)
}
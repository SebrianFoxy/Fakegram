package messages

import (
	"fakegram-api/internal/models"
	"log"
	"sync"
	"time"
)

type Pool struct {
    Register   chan *Client
    Unregister chan *Client
    Clients    map[string]*Client // userID -> Client
    Broadcast  chan *Message
    mu         sync.RWMutex
}

func NewPool() *Pool {
    return &Pool{
        Register:   make(chan *Client),
        Unregister: make(chan *Client),
        Clients:    make(map[string]*Client),
        Broadcast:  make(chan *Message, 100),
    }
}

func (pool *Pool) Start() {
    for {
        select {
        case client := <-pool.Register:
            pool.mu.Lock()
            pool.Clients[client.UserID] = client
            pool.mu.Unlock()
            
            pool.notifyUserStatus(client.UserID, true)
            log.Printf("User %s connected", client.UserID)

        case client := <-pool.Unregister:
            pool.mu.Lock()
            if _, ok := pool.Clients[client.UserID]; ok {
                delete(pool.Clients, client.UserID)
                
                pool.notifyUserStatus(client.UserID, false)
                log.Printf("User %s disconnected", client.UserID)
            }
            pool.mu.Unlock()

        case message := <-pool.Broadcast:
            pool.broadcastMessage(message)
        }
    }
}

func (pool *Pool) broadcastMessage(message *Message) {
    pool.mu.RLock()
    defer pool.mu.RUnlock()

    for _, client := range pool.Clients {
        if err := client.Conn.WriteJSON(message); err != nil {
            log.Printf("Error broadcasting to client %s: %v", client.UserID, err)
            client.Conn.Close()
        }
    }
}

func (pool *Pool) BroadcastToChat(chatID string, message *Message, excludeUserID string) {
    pool.mu.RLock()
    defer pool.mu.RUnlock()

    for userID, client := range pool.Clients {
        if userID == excludeUserID {
            continue
        }
        
        if err := client.Conn.WriteJSON(message); err != nil {
            log.Printf("Error sending to user %s: %v", userID, err)
        }
    }
}

func (pool *Pool) notifyUserStatus(userID string, online bool) {
    eventType := EventUserOffline
    if online {
        eventType = EventUserOnline
    }

    statusEvent := WSEvent{
        Event: eventType,
        Data: map[string]interface{}{
            "user_id": userID,
            "online":  online,
            "at":      time.Now(),
        },
    }

    pool.Broadcast <- &Message{
        Type:    "event",
        Payload: mustMarshal(statusEvent),
    }
}

func (pool *Pool) SendToUser(userID string, message *Message) error {
    pool.mu.RLock()
    defer pool.mu.RUnlock()

    client, exists := pool.Clients[userID]
    if !exists {
        return &UserNotConnectedError{UserID: userID}
    }

    if err := client.Conn.WriteJSON(message); err != nil {
        log.Printf("Error sending to user %s: %v", userID, err)
        
        go func() {
            pool.Unregister <- client
            client.Conn.Close()
        }()
        
        return err
    }

    log.Printf("Message sent to user %s", userID)
    return nil
}

func (pool *Pool) NotifyChatListUpdate(userID string, chat *models.ChatListItem) {
    log.Printf("🟢 Preparing to send chat update to user %s", userID)
    log.Printf("🟢 Chat data: ID=%s, LastMessage=%v", chat.ID, chat.LastMessage)

    event := WSEvent{
        Event: EventChatListUpdate,
        Data: map[string]interface{}{
            "chat":      chat,
            "timestamp": time.Now().Format(time.RFC3339),
        },
    }

    message := &Message{
        Type:    "event",
        Payload: mustMarshal(event),
    }

    log.Printf("🟢 Sending message to user %s: %s", userID, string(mustMarshal(event)))

    if err := pool.SendToUser(userID, message); err != nil {
        log.Printf("Failed to send chat list update to user %s: %v", userID, err)
    } else {
        log.Printf("Chat list update sent to user %s", userID)
    }
}

type UserNotConnectedError struct {
    UserID string
}

func (e *UserNotConnectedError) Error() string {
    return "user " + e.UserID + " is not connected"
}
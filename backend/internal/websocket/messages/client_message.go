package messages

import (
	"encoding/json"
	"fakegram-api/internal/models"
	"log"
	"sync"
	"time"

	"github.com/gorilla/websocket"
)

type Client struct {
    UserID string
    Conn   *websocket.Conn
    Pool   *Pool
    mu     sync.Mutex
	ActiveChat string
	LastTyping time.Time
}

func (c *Client) Read() {
    defer func() {
        c.Pool.Unregister <- c
        c.Conn.Close()
    }()

    for {
        var msg Message
        err := c.Conn.ReadJSON(&msg)
        if err != nil {
            if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
                log.Printf("WebSocket error: %v", err)
            }
            break
        }

        c.handleMessage(&msg)
    }
}

func (c *Client) handleMessage(msg *Message) {
    switch msg.Type {
    case "typing_start":
        c.handleTypingStart(msg.Payload)
    case "typing_stop":
        c.handleTypingStop(msg.Payload)
    case "message_read":
        c.handleMessageRead(msg.Payload)
    default:
        log.Printf("Unknown message type: %s", msg.Type)
    }
}

func (c *Client) handleTypingStart(payload json.RawMessage) {
    var data struct {
        ChatID string `json:"chat_id"`
    }
    
    if err := json.Unmarshal(payload, &data); err != nil {
        log.Printf("Error unmarshaling typing start: %v", err)
        return
    }

	c.mu.Lock()
    c.LastTyping = time.Now()
    c.ActiveChat = data.ChatID
    c.mu.Unlock()

    event := WSEvent{
        Event: EventUserTyping,
        Data: map[string]interface{}{
            "user_id": c.UserID,
            "chat_id": data.ChatID,
            "typing":  true,
			"at":      time.Now(),
        },
    }

    c.Pool.BroadcastToChat(data.ChatID, &Message{
        Type:    "event",
        Payload: mustMarshal(event),
    }, c.UserID)
}

func (c *Client) handleTypingStop(payload json.RawMessage) {
    var data struct {
        ChatID string `json:"chat_id"`
    }
    
    if err := json.Unmarshal(payload, &data); err != nil {
        log.Printf("Error unmarshaling typing start: %v", err)
        return
    }

    event := WSEvent{
        Event: EventUserTyping,
        Data: map[string]interface{}{
            "user_id": c.UserID,
            "chat_id": data.ChatID,
            "typing":  false,
			"at":      time.Now(),
        },
    }

    c.Pool.BroadcastToChat(data.ChatID, &Message{
        Type:    "event",
        Payload: mustMarshal(event),
    }, c.UserID)
}

func (c *Client) handleMessageRead(payload json.RawMessage) {
    var data struct {
        ChatID     string   `json:"chat_id"`
        MessageIDs []string `json:"message_ids"`
    }
    
    if err := json.Unmarshal(payload, &data); err != nil {
        log.Printf("Ошибка разбора JSON: %v", err)
        return
    }

    if len(data.MessageIDs) == 0 {
        log.Printf("Пустой список message_ids")
        return
    }

    log.Printf("Пользователь %s прочитал %d сообщений в чате %s", 
        c.UserID, len(data.MessageIDs), data.ChatID)

    user1, user2, err := models.ExtractUsersFromChatID(data.ChatID)
    if err != nil {
        log.Printf("Ошибка извлечения пользователей: %v", err)
        return
    }

    var otherUserID string
    if user1 == c.UserID {
        otherUserID = user2
    } else {
        otherUserID = user1 
    }

    event := WSEvent{
        Event: "messages_read",
        Data: map[string]interface{}{
            "user_id":     c.UserID,  
            "chat_id":     data.ChatID, 
            "message_ids": data.MessageIDs,
            "read_at":     time.Now().Format(time.RFC3339),
        },
    }

    c.Pool.SendToUser(otherUserID, &Message{
        Type:    "event",
        Payload: mustMarshal(event),
    })

    log.Printf("Уведомили пользователя %s о прочтении", otherUserID)
}

func (c *Client) StartTypingTimer() {
    ticker := time.NewTicker(1 * time.Second)
    defer ticker.Stop()

    for range ticker.C {
        c.mu.Lock()
        if !c.LastTyping.IsZero() && time.Since(c.LastTyping) > 3*time.Second {
            if c.ActiveChat != "" {
                c.mu.Unlock()
                
                event := WSEvent{
                    Event: EventUserTyping,
                    Data: map[string]interface{}{
                        "user_id": c.UserID,
                        "chat_id": c.ActiveChat,
                        "typing":  false,
                        "at":      time.Now(),
                    },
                }

                c.Pool.BroadcastToChat(c.ActiveChat, &Message{
                    Type:    "event",
                    Payload: mustMarshal(event),
                }, c.UserID)

                c.mu.Lock()
                c.LastTyping = time.Time{}
                c.ActiveChat = ""
                c.mu.Unlock()

                log.Printf("Auto typing stop for user %s in chat %s", c.UserID, c.ActiveChat)
            }
        }
        c.mu.Unlock()
    }
}

func mustMarshal(v interface{}) json.RawMessage {
    data, err := json.Marshal(v)

	if err != nil {
        log.Printf("Marshal error: %v", err)
        return json.RawMessage(`{"error": "marshal_failed"}`)
    }

    return data
}
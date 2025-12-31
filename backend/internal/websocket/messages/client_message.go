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
    LastPing    time.Time     
    IsAlive     bool          
    PingTicker  *time.Ticker  
    Done        chan bool  
}

func NewClient(userID string, conn *websocket.Conn, pool *Pool) *Client {
    return &Client{
        UserID:     userID,
        Conn:       conn,
        Pool:       pool,
        IsAlive:    true,
        PingTicker: time.NewTicker(30 * time.Second),
        Done:       make(chan bool),
    }
}

func (c *Client) Read() {
    defer func() {
        c.Pool.Unregister <- c
        c.Conn.Close()
        // c.StopPingTicker()
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
    // case "ping":
    //     c.handlePing(msg.Payload)
    // case "pong": 
    //     c.handlePong(msg.Payload)
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

// func (c *Client) handlePing(payload json.RawMessage) {
//     var pingData PingPayload
//     if err := json.Unmarshal(payload, &pingData); err != nil {
//         log.Printf("Error unmarshaling ping from user %s: %v", c.UserID, err)
//         return
//     }
    
//     latency := time.Now().UnixMilli() - pingData.Timestamp
    
//     pongEvent := WSEvent{
//         Event: EventPong,
//         Data: PongPayload{
//             Timestamp: time.Now().UnixMilli(),
//             Latency:   latency,
//         },
//     }
    
//     message := &Message{
//         Type:    "event",
//         Payload: mustMarshal(pongEvent),
//     }
    
//     c.mu.Lock()
//     defer c.mu.Unlock()
    
//     if err := c.Conn.WriteJSON(message); err != nil {
//         log.Printf("Failed to send pong to user %s: %v", c.UserID, err)
//     } else {
//         log.Printf("Sent pong to user %s (latency: %dms)", c.UserID, latency)
//     }
// }

// func (c *Client) handlePong(payload json.RawMessage) {
//     c.mu.Lock()
//     c.IsAlive = true
//     c.LastPing = time.Now()
//     c.mu.Unlock()
    
//     log.Printf("Received pong from user %s", c.UserID)
// }

// func (c *Client) StartPingTicker() {
//     go func() {
//         for {
//             select {
//             case <-c.PingTicker.C:
//                 c.sendPing()
//             case <-c.Done:
//                 return
//             }
//         }
//     }()
// }

// func (c *Client) StopPingTicker() {
//     if c.PingTicker != nil {
//         c.PingTicker.Stop()
//     }
//     close(c.Done)
// }

// func (c *Client) sendPing() {
//     c.mu.Lock()
    
//     if !c.IsAlive {
//         log.Printf("Client %s is not responding, closing connection", c.UserID)
//         c.mu.Unlock()
//         c.Conn.Close()
//         return
//     }
    
//     c.IsAlive = false
    
//     // pingEvent := WSEvent{
//     //     Event: EventPing,
//     //     Data: PingPayload{
//     //         Timestamp: time.Now().UnixMilli(),
//     //     },
//     // }
    
//     message := &Message{
//         Type:    "event",
//         Payload: mustMarshal(pingEvent),
//     }
    
//     if err := c.Conn.WriteJSON(message); err != nil {
//         log.Printf("Failed to send ping to user %s: %v", c.UserID, err)
//         c.mu.Unlock()
//         c.Conn.Close()
//         return
//     }
    
//     c.mu.Unlock()
    
//     log.Printf("Sent ping to user %s", c.UserID)
    
//     go c.checkPongResponse()
// }

// func (c *Client) checkPongResponse() {
//     time.Sleep(10 * time.Second)
    
//     c.mu.Lock()
//     defer c.mu.Unlock()
    
//     if !c.IsAlive && c.Conn != nil {
//         log.Printf("User %s did not respond to ping, closing connection", c.UserID)
//         c.Conn.Close()
//     }
// }

func (c *Client) StartTypingTimer() {
    ticker := time.NewTicker(1 * time.Second)
    defer ticker.Stop()

    for range ticker.C {
        c.mu.Lock()
        if !c.LastTyping.IsZero() && time.Since(c.LastTyping) > 3*time.Second {
            if c.ActiveChat != "" {
                activeChat := c.ActiveChat
                c.mu.Unlock()
                
                event := WSEvent{
                    Event: EventUserTyping,
                    Data: map[string]interface{}{
                        "user_id": c.UserID,
                        "chat_id": activeChat,
                        "typing":  false,
                        "at":      time.Now(),
                    },
                }

                c.Pool.BroadcastToChat(activeChat, &Message{
                    Type:    "event",
                    Payload: mustMarshal(event),
                }, c.UserID)

                c.mu.Lock()
                c.LastTyping = time.Time{}
                c.ActiveChat = ""
                c.mu.Unlock()

                log.Printf("Auto typing stop for user %s in chat %s", c.UserID, activeChat)
            } else {
                c.mu.Unlock()
            }
        } else {
            c.mu.Unlock()
        }
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
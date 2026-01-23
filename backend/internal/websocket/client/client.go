package client

import (
	"fakegram-api/internal/websocket/types"
	"fakegram-api/internal/websocket/utils"
	"log"
	"sync"
	"time"

	"github.com/gorilla/websocket"
)

type Client struct {
    UserID      string
    Conn        *websocket.Conn
    Pool        types.PoolInterface
    mu          sync.Mutex
    ActiveChat  string
    LastTyping  int64 
    LastPing    time.Time
    IsAlive     bool
    PingTicker  *time.Ticker
    Done        chan bool
}

func NewClient(userID string, conn *websocket.Conn, pool types.PoolInterface) *Client {
    return &Client{
        UserID:     userID,
        Conn:       conn,
        Pool:       pool,
        IsAlive:    true,
        PingTicker: time.NewTicker(30 * time.Second),
        Done:       make(chan bool),
    }
}

func (c *Client) GetUserID() string {
    return c.UserID
}

func (c *Client) GetConn() *websocket.Conn {
    return c.Conn
}

func (c *Client) SendMessage(message *types.Message) error {
    return c.Conn.WriteJSON(message)
}

func (c *Client) Close() {
    c.Conn.Close()
}

func (c *Client) GetActiveChat() string {
    c.mu.Lock()
    defer c.mu.Unlock()
    return c.ActiveChat
}

func (c *Client) SetActiveChat(chatID string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.ActiveChat = chatID
}

func (c *Client) GetLastTyping() int64 {
    c.mu.Lock()
    defer c.mu.Unlock()
    return c.LastTyping
}

func (c *Client) SetLastTyping(timestamp int64) {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.LastTyping = timestamp
}

func (c *Client) ResetTyping() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.LastTyping = 0
    c.ActiveChat = ""
}



func (c *Client) Read(handler types.EventHandler) {
    defer func() {
        c.Pool.UnregisterClient(c)
        c.Close()
    }()

    for {
        var msg types.Message
        err := c.Conn.ReadJSON(&msg)
        if err != nil {
            if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
                log.Printf("WebSocket error: %v", err)
            }
            break
        }

        if handler != nil {
            if err := handler.Handle(c.UserID, msg.Type, msg.Payload); err != nil {
                log.Printf("Error handling event %s: %v", msg.Type, err)
                c.sendError(msg.Type, err.Error())
            }
        }
    }
}


func (c *Client) sendError(eventType string, errorMsg string) {
    errorEvent := types.WSEvent{
        Event: "error",
        Data: map[string]interface{}{
            "event_type": eventType,
            "error":      errorMsg,
            "timestamp":  time.Now(),
        },
    }
    
    c.Conn.WriteJSON(types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(errorEvent),
    })
}

func (c *Client) StartTypingTimer() {
    ticker := time.NewTicker(1 * time.Second)
    defer ticker.Stop()

    for range ticker.C {
        lastTyping := c.GetLastTyping()
        activeChat := c.GetActiveChat()
        
        if lastTyping > 0 && time.Now().Unix()-lastTyping > 3 {
            if activeChat != "" {
                c.handleAutoTypingStop(activeChat)
            }
        }
    }
}

func (c *Client) handleAutoTypingStop(chatID string) {
    event := types.WSEvent{
        Event: types.EventUserTyping,
        Data: map[string]interface{}{
            "user_id": c.UserID,
            "chat_id": chatID,
            "typing":  false,
            "at":      time.Now(),
        },
    }

    c.Pool.BroadcastToChat(chatID, &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }, c.UserID)

    c.ResetTyping()
    log.Printf("Auto typing stop for user %s in chat %s", c.UserID, chatID)
}
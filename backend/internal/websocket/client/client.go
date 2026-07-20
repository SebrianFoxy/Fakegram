package client

import (
	"fakegram-api/internal/websocket/events"
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
    Pool        events.PoolInterface
    mu          sync.Mutex       
    ActiveChat  string
    Chats       map[string]bool 
    LastTyping  int64 
    LastPing    time.Time
    IsAlive     bool
    PingTicker  *time.Ticker
    Done        chan bool
    closed      bool            
}

func NewClient(userID string, conn *websocket.Conn, pool events.PoolInterface) *Client {
    client := &Client{
        UserID:     userID,
        Conn:       conn,
        Pool:       pool,
        Chats:      make(map[string]bool),
        IsAlive:    true,
        PingTicker: time.NewTicker(30 * time.Second),
        Done:       make(chan bool),
    }

    go client.sendWelcomeMessage()
    
    return client
}

func (c *Client) sendWelcomeMessage() {
    welcomeEvent := types.WSEvent{
        Event: types.EventConnected,
        Data: map[string]interface{}{
            "user_id":    c.UserID,
            "timestamp":  time.Now().UnixMilli(),
            "message":    "WebSocket connection established",
        },
    }
    
    welcomeMsg := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(welcomeEvent),
    }
    
    if err := c.SendMessage(welcomeMsg); err != nil {
        log.Printf("Failed to send welcome message to user %s: %v", c.UserID, err)
    } else {
        log.Printf("Welcome message sent to user: %s", c.UserID)
    }
}

func (c *Client) SendMessage(message *types.Message) error {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    if c.Conn == nil || c.closed {
        return nil
    }
    
    return c.Conn.WriteJSON(message)
}

func (c *Client) IsInChat(chatID string) bool {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    _, exists := c.Chats[chatID]
    return exists
}

func (c *Client) JoinChat(chatID string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    c.Chats[chatID] = true
    log.Printf("User %s joined chat %s", c.UserID, chatID)
}

func (c *Client) LeaveChat(chatID string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    delete(c.Chats, chatID)
    
    if c.ActiveChat == chatID {
        c.ActiveChat = ""
        c.LastTyping = 0
    }
    
    log.Printf("User %s left chat %s", c.UserID, chatID)
}

func (c *Client) SubscribeToChats(chatIDs []string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    for _, chatID := range chatIDs {
        c.Chats[chatID] = true
    }
    
    log.Printf("User %s subscribed to %d chats", c.UserID, len(chatIDs))
}

func (c *Client) GetChats() []string {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    chats := make([]string, 0, len(c.Chats))
    for chatID := range c.Chats {
        chats = append(chats, chatID)
    }
    return chats
}

func (c *Client) Close() {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    if c.closed {
        return
    }
    
    c.closed = true
    if c.PingTicker != nil {
        c.PingTicker.Stop()
    }
    if c.Conn != nil {
        c.Conn.Close()
    }
    close(c.Done)
}

func (c *Client) GetUserID() string {
    return c.UserID
}

func (c *Client) GetConn() *websocket.Conn {
    return c.Conn
}

func (c *Client) GetActiveChat() string {
    c.mu.Lock()
    defer c.mu.Unlock()
    return c.ActiveChat
}

func (c *Client) SetActiveChat(chatID string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    
    if _, exists := c.Chats[chatID]; exists {
        c.ActiveChat = chatID
    } else {
        log.Printf("Warning: User %s trying to set active chat %s without subscription", c.UserID, chatID)
    }
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

func (c *Client) Read(handler events.EventHandler) {
    defer func() {
        c.Pool.UnregisterClient(c)
        c.Close()
        log.Printf("Client %s disconnected", c.UserID)
    }()

    for {
        var msg types.Message
        err := c.Conn.ReadJSON(&msg)
        if err != nil {
            if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
                log.Printf("WebSocket read error for user %s: %v", c.UserID, err)
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
    
    msg := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(errorEvent),
    }
    
    if err := c.SendMessage(msg); err != nil {
        log.Printf("Failed to send error message to user %s: %v", c.UserID, err)
    }
}

func (c *Client) StartTypingTimer() {
    ticker := time.NewTicker(1 * time.Second)
    defer ticker.Stop()

    for {
        select {
        case <-ticker.C:
            c.checkTypingTimeout()
        case <-c.Done:
            return
        }
    }
}

func (c *Client) checkTypingTimeout() {
    lastTyping := c.GetLastTyping()
    activeChat := c.GetActiveChat()
    
    if lastTyping > 0 && time.Now().Unix()-lastTyping > 3 {
        if activeChat != "" {
            c.handleAutoTypingStop(activeChat)
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

    msg := &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(event),
    }

    c.Pool.BroadcastToChat(chatID, msg, c.UserID)
    c.ResetTyping()
    log.Printf("Auto typing stop for user %s in chat %s", c.UserID, chatID)
}
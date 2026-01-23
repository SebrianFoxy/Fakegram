package pool

import (
    "fakegram-api/internal/websocket/types"
    "fakegram-api/internal/websocket/utils"
    "log"
    "sync"
    "time"
)

type Pool struct {
    Register   chan types.ClientInterface
    Unregister chan types.ClientInterface
    Clients    map[string]types.ClientInterface
    Broadcast  chan *types.Message
    mu         sync.RWMutex
}

func NewPool() *Pool {
    return &Pool{
        Register:   make(chan types.ClientInterface),
        Unregister: make(chan types.ClientInterface),
        Clients:    make(map[string]types.ClientInterface),
        Broadcast:  make(chan *types.Message, 100),
    }
}

func (p *Pool) Start() {
    for {
        select {
        case client := <-p.Register:
            p.registerClient(client)

        case client := <-p.Unregister:
            p.unregisterClient(client)

        case message := <-p.Broadcast:
            p.broadcastMessage(message)
        }
    }
}

func (p *Pool) registerClient(client types.ClientInterface) {
    p.mu.Lock()
    p.Clients[client.GetUserID()] = client
    p.mu.Unlock()
    
    p.notifyUserStatus(client.GetUserID(), true)
    log.Printf("User %s connected", client.GetUserID())
}

func (p *Pool) unregisterClient(client types.ClientInterface) {
    p.mu.Lock()
    if _, ok := p.Clients[client.GetUserID()]; ok {
        delete(p.Clients, client.GetUserID())
        p.notifyUserStatus(client.GetUserID(), false)
        log.Printf("User %s disconnected", client.GetUserID())
    }
    p.mu.Unlock()
}

func (p *Pool) notifyUserStatus(userID string, online bool) {
    eventType := types.EventUserOffline
    if online {
        eventType = types.EventUserOnline
    }

    statusEvent := types.WSEvent{
        Event: eventType,
        Data: map[string]interface{}{
            "user_id": userID,
            "online":  online,
            "at":      time.Now(),
        },
    }

    p.Broadcast <- &types.Message{
        Type:    "event",
        Payload: utils.MustMarshal(statusEvent),
    }
}

func (p *Pool) UnregisterClient(client types.ClientInterface) {
    p.Unregister <- client
}

func (p *Pool) GetClient(userID string) types.ClientInterface {
    p.mu.RLock()
    defer p.mu.RUnlock()
    return p.Clients[userID]
}

func (p *Pool) IsUserOnline(userID string) bool {
    p.mu.RLock()
    defer p.mu.RUnlock()
    _, exists := p.Clients[userID]
    return exists
}

func (p *Pool) GetOnlineUsers() []string {
    p.mu.RLock()
    defer p.mu.RUnlock()
    
    users := make([]string, 0, len(p.Clients))
    for userID := range p.Clients {
        users = append(users, userID)
    }
    return users
}
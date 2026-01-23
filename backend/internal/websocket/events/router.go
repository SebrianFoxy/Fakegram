package events

import (
    "encoding/json"
    "fakegram-api/internal/websocket/types"
    "log"
)

type Router struct {
    handlers map[string]types.EventHandler
}

func NewRouter() *Router {
    return &Router{
        handlers: make(map[string]types.EventHandler),
    }
}

func (r *Router) Register(eventType string, handler types.EventHandler) {
    r.handlers[eventType] = handler
}

func (r *Router) RegisterFunc(eventType string, handlerFunc func(clientID string, payload json.RawMessage) error) {
    r.handlers[eventType] = types.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
        return handlerFunc(clientID, payload)
    })
}

func (r *Router) Handle(clientID string, eventType string, payload json.RawMessage) error {
    if handler, exists := r.handlers[eventType]; exists {
        return handler.Handle(clientID, eventType, payload)
    }
    log.Printf("No handler for event type: %s", eventType)
    return nil
}
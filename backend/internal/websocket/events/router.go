package events

import (
    "encoding/json"
    "log"
)

type Router struct {
    handlers map[string]EventHandler
}

func NewRouter() *Router {
    return &Router{
        handlers: make(map[string]EventHandler),
    }
}

func (r *Router) Register(eventType string, handler EventHandler) {
    r.handlers[eventType] = handler
}

func (r *Router) RegisterFunc(eventType string, handlerFunc func(clientID string, payload json.RawMessage) error) {
    r.handlers[eventType] = EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
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
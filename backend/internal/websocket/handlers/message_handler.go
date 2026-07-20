package handlers

import (
	"context"
	"encoding/json"
	"fakegram-api/internal/models"
	"fakegram-api/internal/websocket/events"
	"fakegram-api/internal/websocket/utils"
	"fmt"
	"log"
)

type MessageHandlers struct {
	messageService MessageServiceInterface
}

func NewMessageHandlers(messageService MessageServiceInterface) *MessageHandlers {
	return &MessageHandlers{
		messageService: messageService,
	}
}

func (h *MessageHandlers) HandleNewMessage(clientID string, payload json.RawMessage) error {
	var req models.CreateMessageRequest

	if err := utils.SafeUnmarshal(payload, &req); err != nil {
		return fmt.Errorf("failed to unmarshal message request: %w", err)
	}

	if req.MessageText == "" {
		return fmt.Errorf("message text is required")
	}

	ctx := context.Background()
	message, err := h.messageService.SendMessage(ctx, clientID, &req)
	if err != nil {
		log.Printf("Error sending message: %v", err)
		return err
	}

	log.Printf("Message sent successfully: %s", message.ID)
	return nil
}

func (h *MessageHandlers) HandleMessageRead(clientID string, payload json.RawMessage) error {
	var data struct {
		ChatID            string `json:"chat_id"`
		LastReadMessageID string `json:"last_read_message_id"`
	}

	if err := utils.SafeUnmarshal(payload, &data); err != nil {
		return fmt.Errorf("failed to unmarshal read receipt: %w", err)
	}

	if data.ChatID == "" {
		return fmt.Errorf("chat_id is required")
	}

	if data.LastReadMessageID == "" {
		return fmt.Errorf("last_read_message_id is required")
	}

	ctx := context.Background()
	err := h.messageService.MarkAsRead(ctx, clientID, data.ChatID, data.LastReadMessageID)
	if err != nil {
		log.Printf("Error marking messages as read: %v", err)
		return err
	}

	log.Printf("User %s marked messages up to %s as read in chat %s",
		clientID, data.LastReadMessageID, data.ChatID)

	return nil
}

func (h *MessageHandlers) HandleMessageReadAll(clientID string, payload json.RawMessage) error {
	var data struct {
		ChatID string `json:"chat_id"`
	}

	if err := utils.SafeUnmarshal(payload, &data); err != nil {
		return fmt.Errorf("failed to unmarshal read all request: %w", err)
	}

	if data.ChatID == "" {
		return fmt.Errorf("chat_id is required")
	}

	ctx := context.Background()
	err := h.messageService.MarkAllAsRead(ctx, clientID, data.ChatID)
	if err != nil {
		log.Printf("Error marking all messages as read: %v", err)
		return err
	}

	log.Printf("User %s marked all messages as read in chat %s", clientID, data.ChatID)

	return nil
}

func (h *MessageHandlers) HandleDeleteMessage(clientID string, payload json.RawMessage) error {
	var data struct {
		MessageID string `json:"message_id"`
	}

	if err := utils.SafeUnmarshal(payload, &data); err != nil {
		return fmt.Errorf("failed to unmarshal delete request: %w", err)
	}

	if data.MessageID == "" {
		return fmt.Errorf("message_id is required")
	}

	ctx := context.Background()
	if err := h.messageService.DeleteMessage(ctx, clientID, data.MessageID); err != nil {
		log.Printf("Error deleting message: %v", err)
		return err
	}

	log.Printf("Message %s deleted by user %s", data.MessageID, clientID)
	return nil
}

func (h *MessageHandlers) HandleEditMessage(clientID string, payload json.RawMessage) error {
	var data struct {
		MessageID   string `json:"message_id"`
		MessageText string `json:"message_text"`
	}

	if err := utils.SafeUnmarshal(payload, &data); err != nil {
		return fmt.Errorf("failed to unmarshal edit request: %w", err)
	}

	if data.MessageID == "" {
		return fmt.Errorf("message_id is required")
	}

	if data.MessageText == "" {
		return fmt.Errorf("message_text is required")
	}

	ctx := context.Background()
	req := &models.UpdateMessageRequest{
		MessageText: data.MessageText,
	}

	message, err := h.messageService.EditMessage(ctx, clientID, data.MessageID, req)
	if err != nil {
		log.Printf("Error editing message: %v", err)
		return err
	}

	log.Printf("Message %s edited by user %s", message.ID, clientID)
	return nil
}

func (h *MessageHandlers) CreateNewMessageHandler() events.EventHandler {
	return events.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
		return h.HandleNewMessage(clientID, payload)
	})
}

func (h *MessageHandlers) CreateMessageReadHandler() events.EventHandler {
	return events.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
		return h.HandleMessageRead(clientID, payload)
	})
}

func (h *MessageHandlers) CreateMessageReadAllHandler() events.EventHandler {
	return events.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
		return h.HandleMessageReadAll(clientID, payload)
	})
}

func (h *MessageHandlers) CreateDeleteMessageHandler() events.EventHandler {
	return events.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
		return h.HandleDeleteMessage(clientID, payload)
	})
}

func (h *MessageHandlers) CreateEditMessageHandler() events.EventHandler {
	return events.EventHandlerFunc(func(clientID string, eventType string, payload json.RawMessage) error {
		return h.HandleEditMessage(clientID, payload)
	})
}
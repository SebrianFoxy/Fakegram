package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"fakegram-api/internal/models"

	"github.com/lib/pq"
)


type MessageRepository struct {
	DB *sql.DB
}

func NewMessageRepository(db *sql.DB) *MessageRepository {
	return &MessageRepository{DB: db}
}


func (r *MessageRepository) CreatePrivateMessage(ctx context.Context, senderID, receiverID string, req *models.CreateMessageRequest) (*models.Message, error) {
    var approvedCount int
    err := r.DB.QueryRowContext(ctx, 
        `SELECT COUNT(*) FROM users WHERE id IN ($1, $2) AND approved = true`,
        senderID, receiverID,
    ).Scan(&approvedCount)
    
    if err != nil {
        return nil, fmt.Errorf("failed to verify users: %w", err)
    }
    
    if approvedCount != 2 {
        return nil, fmt.Errorf("one or both users are not approved")
    }

    chatID := models.GenerateChatID(senderID, receiverID)
    
    message := &models.Message{
        ChatID:           chatID,
        SenderID:         senderID,
        MessageText:      req.MessageText,
        MessageType:      req.MessageType,
        ReplyToMessageID: req.ReplyToMessageID,
        IsEdited:         false,
        IsDeleted:        false,
    }
    
    query := `
        INSERT INTO messages (chat_id, sender_id, message_text, message_type, reply_to_message_id)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING id, is_edited, is_deleted, created_at
    `

    var replyTo interface{}
    if req.ReplyToMessageID != nil && *req.ReplyToMessageID != "" {
        replyTo = *req.ReplyToMessageID
    } else {
        replyTo = nil
    }
    
    err = r.DB.QueryRowContext(ctx, query,
        message.ChatID,
        message.SenderID,
        message.MessageText,
        message.MessageType,
        replyTo,
    ).Scan(&message.ID, &message.IsEdited, &message.IsDeleted, &message.CreatedAt)
    
    if err != nil {
        return nil, fmt.Errorf("failed to create private message: %w", err)
    }
    
    return message, nil
}

func (r *MessageRepository) GetMessagesByChat(ctx context.Context, userID, otherUserID string, limit, offset int) ([]*models.MessageDetail, int, error) {
    chatID := models.GenerateChatID(userID, otherUserID)
    
    query := `
        SELECT 
            m.id,
            m.chat_id,
            m.sender_id,
            m.message_text,
            m.message_type,
            m.reply_to_message_id,
            m.is_edited,
            m.is_deleted,
            m.created_at,
            u.name as sender_name,
            u.surname as sender_surname,
            u.nickname as sender_nickname,
            u.avatar_url as sender_avatar_url,
            EXISTS(
                SELECT 1 FROM message_read_status mrs 
                WHERE mrs.message_id = m.id AND mrs.user_id = $1
            ) as is_read
        FROM messages m
        JOIN users u ON m.sender_id = u.id
        WHERE m.chat_id = $2 AND m.is_deleted = false
        ORDER BY m.created_at DESC
        LIMIT $3 OFFSET $4
    `
    
    rows, err := r.DB.QueryContext(ctx, query, userID, chatID, limit, offset)
    if err != nil {
        return nil, 0, fmt.Errorf("failed to get messages: %w", err)
    }
    defer rows.Close()
    
    var messages []*models.MessageDetail
    for rows.Next() {
        var message models.MessageDetail
        var isRead bool
        
        err := rows.Scan(
            &message.ID,
            &message.ChatID,
            &message.SenderID,
            &message.MessageText,
            &message.MessageType,
            &message.ReplyToMessageID,
            &message.IsEdited,
            &message.IsDeleted,
            &message.CreatedAt,
            &message.SenderName,
            &message.SenderSurname,
            &message.SenderNickname,
            &message.SenderAvatarURL,
            &isRead,
        )
        if err != nil {
            return nil, 0, fmt.Errorf("failed to scan message: %w", err)
        }
        
        message.IsRead = isRead
        messages = append(messages, &message)
    }
    
    var totalCount int
    countQuery := `SELECT COUNT(*) FROM messages WHERE chat_id = $1 AND is_deleted = false`
    err = r.DB.QueryRowContext(ctx, countQuery, chatID).Scan(&totalCount)
    if err != nil {
        return nil, 0, fmt.Errorf("failed to get total count: %w", err)
    }
    
    return messages, totalCount, nil
}

func (r *MessageRepository) MarkMessagesAsReadBatch(userID string, messageIDs []string) error {
    if len(messageIDs) == 0 {
        return nil
    }

    query := `
        WITH message_ids AS (
            SELECT unnest($2::uuid[]) as message_id
        )
        INSERT INTO message_read_status (message_id, user_id, read_at)
        SELECT 
            mi.message_id, 
            $1,           
            $3             
        FROM message_ids mi
        WHERE EXISTS (
            SELECT 1 FROM messages m 
            WHERE m.id = mi.message_id 
            AND m.sender_id != $1
        )
        AND NOT EXISTS (
            SELECT 1 FROM message_read_status mrs 
            WHERE mrs.message_id = mi.message_id 
            AND mrs.user_id = $1
        )
        ON CONFLICT (message_id, user_id) DO UPDATE SET read_at = $3
    `
    
    _, err := r.DB.Exec(query, userID, pq.Array(messageIDs), time.Now())
    if err != nil {
        return fmt.Errorf("failed to mark messages as read: %w", err)
    }

    return nil
}
package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"fakegram-api/internal/models"
)


type MessageRepository struct {
	DB *sql.DB
}

func NewMessageRepository(db *sql.DB) *MessageRepository {
	return &MessageRepository{DB: db}
}


func (r *MessageRepository) CreatePrivateMessage(ctx context.Context, senderID, receiverID string, req *models.CreateMessageRequest) (*models.MessageDetail, error) {
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
    
    var messageID string
    var isEdited, isDeleted bool
    var createdAt time.Time
    
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
        chatID,        
        senderID,     
        req.MessageText, 
        req.MessageType, 
        replyTo,    
    ).Scan(&messageID, &isEdited, &isDeleted, &createdAt)

    if err != nil {
        return nil, fmt.Errorf("failed to create private message: %w", err)
    }
    
    return r.GetMessageDetailByID(ctx, messageID, senderID)
}

func (r *MessageRepository) GetMessageDetailByID(ctx context.Context, messageID, userID string) (*models.MessageDetail, error) {
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
            u.name,
            u.surname,
            u.nickname,
            u.avatar_url,
            CASE WHEN mrs.id IS NOT NULL THEN true ELSE false END,
            mrs.read_at
        FROM messages m
        JOIN users u ON m.sender_id = u.id
        LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $2
        WHERE m.id = $1
    `
    
    var msgID, chatID, senderID, messageText, messageType string
    var replyToMessageID *string
    var isEdited, isDeleted, isRead bool
    var createdAt time.Time
    var senderName, senderSurname, senderNickname string
    var senderAvatarURL *string
    var readAt sql.NullTime
    
    err := r.DB.QueryRowContext(ctx, query, messageID, userID).Scan(
        &msgID,
        &chatID,
        &senderID,
        &messageText,
        &messageType,
        &replyToMessageID,
        &isEdited,
        &isDeleted,
        &createdAt,
        &senderName,
        &senderSurname,
        &senderNickname,
        &senderAvatarURL,
        &isRead,
        &readAt,
    )
    
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, fmt.Errorf("message not found")
        }
        return nil, fmt.Errorf("failed to get message detail: %w", err)
    }
    
    var readAtPtr *time.Time
    if readAt.Valid {
        readAtPtr = &readAt.Time
    }
    
    msg := &models.Message{
        ID:               msgID,
        ChatID:           chatID,
        SenderID:         senderID,
        MessageText:      messageText,
        MessageType:      models.MessageType(messageType),
        ReplyToMessageID: replyToMessageID,
        IsEdited:         isEdited,
        IsDeleted:        isDeleted,
        CreatedAt:        createdAt,
    }
    
    sender := &models.User{
        Name:      senderName,
        Surname:   senderSurname,
        Nickname:  senderNickname,
        AvatarURL: senderAvatarURL,
    }
    
    return models.ToMessageDetail(msg, isRead, readAtPtr, sender), nil
}

func (r *MessageRepository) GetMessagesByChat(ctx context.Context, userID, otherUserID string, limit, offset int) ([]*models.MessageDetail, int, error) {
    if userID == "" || otherUserID == "" {
        return nil, 0, fmt.Errorf("user IDs cannot be empty")
    }
    
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
            CASE WHEN mrs.id IS NOT NULL THEN true ELSE false END as is_read,
            mrs.read_at
        FROM messages m
        JOIN users u ON m.sender_id = u.id
        LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $1
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
        var messageID, chatID, senderID, messageText, messageType string
        var replyToMessageID *string
        var isEdited, isDeleted bool
        var createdAt time.Time
        var senderName, senderSurname, senderNickname string
        var senderAvatarURL *string
        var isRead bool
        var readAt sql.NullTime
        
        err := rows.Scan(
            &messageID,
            &chatID,
            &senderID,
            &messageText,
            &messageType,
            &replyToMessageID,
            &isEdited,
            &isDeleted,
            &createdAt,
            &senderName,
            &senderSurname,
            &senderNickname,
            &senderAvatarURL,
            &isRead,
            &readAt,
        )
        if err != nil {
            return nil, 0, fmt.Errorf("failed to scan message: %w", err)
        }
        
        msg := &models.Message{
            ID:               messageID,
            ChatID:           chatID,
            SenderID:         senderID,
            MessageText:      messageText,
            MessageType:      models.MessageType(messageType),
            ReplyToMessageID: replyToMessageID,
            IsEdited:         isEdited,
            IsDeleted:        isDeleted,
            CreatedAt:        createdAt,
        }
        
        var readAtPtr *time.Time
        if readAt.Valid {
            readAtPtr = &readAt.Time
        }
        
        sender := &models.User{
            Name:      senderName,
            Surname:   senderSurname,
            Nickname:  senderNickname,
            AvatarURL: senderAvatarURL,
        }
        
        messageDetail := models.ToMessageDetail(msg, isRead, readAtPtr, sender)
        messages = append(messages, messageDetail)
    }

    if err := rows.Err(); err != nil {
        return nil, 0, fmt.Errorf("rows iteration error: %w", err)
    }
    
    var totalCount int
    countQuery := `SELECT COUNT(*) FROM messages WHERE chat_id = $1 AND is_deleted = false`
    err = r.DB.QueryRowContext(ctx, countQuery, chatID).Scan(&totalCount)
    if err != nil {
        return nil, 0, fmt.Errorf("failed to get total count: %w", err)
    }
    
    return messages, totalCount, nil
}

func (r *MessageRepository) MarkMessagesAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error {
    user1, user2, err := models.ExtractUsersFromChatID(chatID)
    if err != nil {
        return fmt.Errorf("invalid chat ID: %w", err)
    }
    
    if userID != user1 && userID != user2 {
        return fmt.Errorf("user is not a participant of this chat")
    }
    
    var lastReadTime time.Time
    timeQuery := `SELECT created_at FROM messages WHERE id = $1 AND chat_id = $2`
    err = r.DB.QueryRowContext(ctx, timeQuery, lastReadMessageID, chatID).Scan(&lastReadTime)
    if err != nil {
        if err == sql.ErrNoRows {
            return fmt.Errorf("message not found in this chat")
        }
        return fmt.Errorf("failed to get message time: %w", err)
    }
    
    markQuery := `
        INSERT INTO message_read_status (message_id, user_id, read_at)
        SELECT m.id, $1, $3
        FROM messages m
        LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $1
        WHERE m.chat_id = $2 
            AND m.sender_id != $1 
            AND mrs.id IS NULL
            AND m.created_at <= $4
            AND NOT m.is_deleted
        ON CONFLICT (message_id, user_id) DO NOTHING
    `
    
    _, err = r.DB.ExecContext(ctx, markQuery, 
        userID, 
        chatID, 
        time.Now(), 
        lastReadTime,
    )
    
    if err != nil {
        return fmt.Errorf("failed to mark messages as read: %w", err)
    }
    
    return nil
}

func (r *MessageRepository) GetUnreadCount(ctx context.Context, chatID, userID string) (int, error) {
    query := `
        SELECT COUNT(*)
        FROM messages m
        LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $1
        WHERE m.chat_id = $2 
            AND m.sender_id != $1 
            AND mrs.id IS NULL
            AND NOT m.is_deleted
    `
    
    var count int
    err := r.DB.QueryRowContext(ctx, query, userID, chatID).Scan(&count)
    if err != nil {
        return 0, fmt.Errorf("failed to get unread count: %w", err)
    }
    
    return count, nil
}
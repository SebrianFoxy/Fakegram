package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"log"
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
    
    sender := &models.UserDetail{
        Name:      senderName,
        Surname:   senderSurname,
        Nickname:  senderNickname,
        AvatarURL: senderAvatarURL,
    }
    
    return models.ToMessageDetail(msg, isRead, readAtPtr, sender), nil
}

func (r *MessageRepository) GetMessagesByChat(ctx context.Context, userID, otherUserID string, cursor *time.Time, limit int, direction string) ([]*models.MessageDetail, bool, bool, int64, error) {
    if userID == "" || otherUserID == "" {
        return nil, false, false, 0, fmt.Errorf("user IDs cannot be empty")
    }
    
    chatID := models.GenerateChatID(userID, otherUserID)
    log.Printf("DEBUG GetMessagesByChat: chat=%s, userID=%s, otherUserID=%s, cursor=%v, limit=%d, direction=%s", 
        chatID, userID, otherUserID, cursor, limit, direction)
    
    if (direction == "older" || direction == "newer") && cursor == nil {
        return nil, false, false, 0, fmt.Errorf("cursor is required for direction: %s", direction)
    }
    
    switch direction {
    case "around":
        return r.getInitialMessages(ctx, userID, otherUserID, chatID, limit)
    case "older":
        return r.getOlderMessages(ctx, userID, otherUserID, chatID, *cursor, limit)
    case "newer":
        return r.getNewerMessages(ctx, userID, otherUserID, chatID, *cursor, limit)
    default:
        return nil, false, false, 0, fmt.Errorf("invalid direction: %s", direction)
    }
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
    timeQuery := `
        SELECT created_at 
        FROM messages 
        WHERE id = $1 AND chat_id = $2 AND NOT is_deleted
    `
    err = r.DB.QueryRowContext(ctx, timeQuery, lastReadMessageID, chatID).Scan(&lastReadTime)
    if err != nil {
        if err == sql.ErrNoRows {
            return fmt.Errorf("message not found in this chat")
        }
        return fmt.Errorf("failed to get message time: %w", err)
    }

    upsertQuery := `
        INSERT INTO message_read_status (message_id, user_id, read_at)
        VALUES ($1, $2, $3)
        ON CONFLICT (message_id, user_id) 
        DO UPDATE SET 
            read_at = EXCLUDED.read_at
        WHERE message_read_status.read_at < EXCLUDED.read_at
    `
    
    result, err := r.DB.ExecContext(ctx, upsertQuery, 
        lastReadMessageID, 
        userID, 
        lastReadTime,
    )
    
    if err != nil {
        return fmt.Errorf("failed to save last read message: %w", err)
    }

    rowsAffected, _ := result.RowsAffected()
    if rowsAffected > 0 {
        log.Printf("Updated last read message for user %s in chat %s to message %s", 
            userID, chatID, lastReadMessageID)
    }

    return nil
}

func (r *MessageRepository) GetLastReadMessage(ctx context.Context, userID, chatID string) (string, error) {
    query := `
        SELECT m.id
        FROM message_read_status mrs
        JOIN messages m ON m.id = mrs.message_id
        WHERE mrs.user_id = $1 AND m.chat_id = $2
        ORDER BY m.created_at DESC
        LIMIT 1
    `
    
    var messageID string
    err := r.DB.QueryRowContext(ctx, query, userID, chatID).Scan(&messageID)
    if err != nil {
        if err == sql.ErrNoRows {
            return "", nil 
        }
        return "", fmt.Errorf("failed to get last read message: %w", err)
    }
    
    return messageID, nil
}

func (r *MessageRepository) GetUnreadCount(ctx context.Context, chatID, userID string) (int, error) {
    query := `
        WITH LastReadTime AS (
            SELECT MAX(m.created_at) as last_read_time
            FROM message_read_status mrs
            JOIN messages m ON m.id = mrs.message_id
            WHERE mrs.user_id = $1 AND m.chat_id = $2
        )
        SELECT COUNT(*)
        FROM messages m
        CROSS JOIN LastReadTime lrt
        WHERE m.chat_id = $2 
            AND m.sender_id != $1 
            AND NOT m.is_deleted
            AND (lrt.last_read_time IS NULL OR m.created_at > lrt.last_read_time)
    `
    
    var count int
    err := r.DB.QueryRowContext(ctx, query, userID, chatID).Scan(&count)
    if err != nil {
        return 0, fmt.Errorf("failed to get unread count: %w", err)
    }
    
    return count, nil
}

func (r *MessageRepository) getInitialMessages(ctx context.Context, userID, otherUserID, chatID string, limit int) ([]*models.MessageDetail, bool, bool, int64, error) {
    var lastReadTime sql.NullTime
    lastReadQuery := `
        SELECT MAX(m.created_at)
        FROM messages m
        JOIN message_read_status mrs ON m.id = mrs.message_id
        WHERE m.chat_id = $1 AND mrs.user_id = $2
    `
    err := r.DB.QueryRowContext(ctx, lastReadQuery, chatID, userID).Scan(&lastReadTime)
    if err != nil && err != sql.ErrNoRows {
        return nil, false, false, 0, fmt.Errorf("failed to get last read time: %w", err)
    }

    var anchorTime time.Time
    var hasUnread bool
    
    if lastReadTime.Valid {
        var firstUnreadTime sql.NullTime
        firstUnreadQuery := `
            SELECT MIN(m.created_at)
            FROM messages m
            LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $2
            WHERE m.chat_id = $1 
            AND m.is_deleted = false
            AND m.sender_id != $4  
            AND mrs.message_id IS NULL  
            AND m.created_at > $3
        `

        err := r.DB.QueryRowContext(ctx, firstUnreadQuery, chatID, otherUserID, lastReadTime.Time, userID).Scan(&firstUnreadTime)
        if err != nil && err != sql.ErrNoRows {
            return nil, false, false, 0, fmt.Errorf("failed to get first unread: %w", err)
        }
        
        if firstUnreadTime.Valid {
            anchorTime = firstUnreadTime.Time
            hasUnread = true
        } else {
            anchorTime = lastReadTime.Time
        }
    } else {
        var oldestMessageTime sql.NullTime
        err := r.DB.QueryRowContext(ctx, `
            SELECT MIN(created_at) FROM messages 
            WHERE chat_id = $1 AND is_deleted = false
        `, chatID).Scan(&oldestMessageTime)
        if err != nil {
            return nil, false, false, 0, fmt.Errorf("failed to get oldest message time: %w", err)
        }
        
        if oldestMessageTime.Valid {
            anchorTime = oldestMessageTime.Time
        } else {
            return []*models.MessageDetail{}, false, false, 0, nil
        }
    }
    
    beforeLimit := limit / 2
    afterLimit := limit - beforeLimit
    
    olderMessages, err := r.getMessagesByTimeRange(ctx, userID, otherUserID, chatID, anchorTime, beforeLimit, "older")
    if err != nil {
        return nil, false, false, 0, err
    }
    
    newerMessages, err := r.getMessagesByTimeRange(ctx, userID, otherUserID, chatID, anchorTime, afterLimit, "newer")
    if err != nil {
        return nil, false, false, 0, err
    }
    
    allMessages := append(olderMessages, newerMessages...)
    
    hasMoreOlder := false
    if len(olderMessages) > 0 {
        oldestTime := olderMessages[0].CreatedAt
        err = r.DB.QueryRowContext(ctx, `
            SELECT EXISTS(
                SELECT 1 FROM messages 
                WHERE chat_id = $1 
                  AND is_deleted = false 
                  AND created_at < $2
            )
        `, chatID, oldestTime).Scan(&hasMoreOlder)
        if err != nil {
            return nil, false, false, 0, err
        }
    }
    
    hasMoreNewer := false
    if len(newerMessages) > 0 {
        newestTime := newerMessages[len(newerMessages)-1].CreatedAt
        err = r.DB.QueryRowContext(ctx, `
            SELECT EXISTS(
                SELECT 1 FROM messages 
                WHERE chat_id = $1 
                  AND is_deleted = false 
                  AND created_at > $2
            )
        `, chatID, newestTime).Scan(&hasMoreNewer)
        if err != nil {
            return nil, false, false, 0, err
        }
    } else if len(olderMessages) > 0 && !hasMoreOlder {
        err = r.DB.QueryRowContext(ctx, `
            SELECT EXISTS(
                SELECT 1 FROM messages 
                WHERE chat_id = $1 
                  AND is_deleted = false 
                  AND created_at > $2
            )
        `, chatID, anchorTime).Scan(&hasMoreNewer)
        if err != nil {
            return nil, false, false, 0, err
        }
    }
    
    var totalUnread int64
    if hasUnread {
        err = r.DB.QueryRowContext(ctx, `
            SELECT COUNT(*)
            FROM messages m
            LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $2
            WHERE m.chat_id = $1 
              AND m.is_deleted = false
              AND m.sender_id != $2
              AND mrs.message_id IS NULL
        `, chatID, otherUserID).Scan(&totalUnread)
        if err != nil {
            return nil, false, false, 0, err
        }
    }
    
    return allMessages, hasMoreOlder, hasMoreNewer, totalUnread, nil
}

func (r *MessageRepository) getOlderMessages(ctx context.Context, userID, otherUserID, chatID string, cursor time.Time, limit int) ([]*models.MessageDetail, bool, bool, int64, error) {
    messages, err := r.getMessagesByTimeRange(ctx, userID, otherUserID, chatID, cursor, limit, "older")
    if err != nil {
        return nil, false, false, 0, err
    }
    
    hasMoreOlder := false
    var oldestTime time.Time
    if len(messages) > 0 {
        oldestTime = messages[len(messages)-1].CreatedAt
        err = r.DB.QueryRowContext(ctx, `
            SELECT EXISTS(
                SELECT 1 FROM messages 
                WHERE chat_id = $1 
                  AND is_deleted = false 
                  AND created_at < $2
            )
        `, chatID, oldestTime).Scan(&hasMoreOlder)
        if err != nil {
            return nil, false, false, 0, err
        }
    }
    
    return messages, hasMoreOlder, true, 0, nil
}

func (r *MessageRepository) getNewerMessages(ctx context.Context, userID, otherUserID, chatID string, cursor time.Time, limit int) ([]*models.MessageDetail, bool, bool, int64, error) {
    messages, err := r.getMessagesByTimeRange(ctx, userID, otherUserID, chatID, cursor, limit, "newer")
    if err != nil {
        return nil, false, false, 0, err
    }
    
    hasMoreNewer := false
    if len(messages) > 0 {
        newestTime := messages[len(messages)-1].CreatedAt
        err = r.DB.QueryRowContext(ctx, `
            SELECT EXISTS(
                SELECT 1 FROM messages 
                WHERE chat_id = $1 
                  AND is_deleted = false 
                  AND created_at > $2
            )
        `, chatID, newestTime).Scan(&hasMoreNewer)
        if err != nil {
            return nil, false, false, 0, err
        }
    }

    
    return messages, true, hasMoreNewer, 0, nil
}

func (r *MessageRepository) getMessagesByTimeRange(ctx context.Context, userID, otherUserID, chatID string, anchorTime time.Time, limit int, direction string) ([]*models.MessageDetail, error) {
    if userID == "" || otherUserID == "" || chatID == "" {
        return nil, fmt.Errorf("userID, otherUserID and chatID cannot be empty")
    }
    
    if limit <= 0 {
        limit = 30
    }
    var query string
    var args []interface{}

    baseQuery := `
        WITH user_last_read AS (
            SELECT 
                user_id,
                MAX(m.created_at) as last_read_time
            FROM message_read_status mrs
            JOIN messages m ON m.id = mrs.message_id
            WHERE m.chat_id = $3 
                AND mrs.user_id IN ($1, $2)
            GROUP BY user_id
        ),
        message_read_info AS (
            SELECT 
                mrs.message_id,
                mrs.user_id,
                mrs.read_at
            FROM message_read_status mrs
            WHERE mrs.user_id IN ($1, $2)
        )
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
            BOOL_OR(CASE WHEN mri.user_id = $1 THEN true ELSE false END) as is_read_by_current_user,
            MAX(CASE WHEN mri.user_id = $1 THEN mri.read_at ELSE NULL END) as current_user_read_at,
            BOOL_OR(CASE WHEN mri.user_id = $2 THEN true ELSE false END) as is_read_by_other_user,
            MAX(CASE WHEN mri.user_id = $2 THEN mri.read_at ELSE NULL END) as other_user_read_at,
            MAX(CASE WHEN url.user_id = $1 THEN url.last_read_time ELSE NULL END) as current_user_last_read,
            MAX(CASE WHEN url.user_id = $2 THEN url.last_read_time ELSE NULL END) as other_user_last_read
        FROM messages m
        JOIN users u ON m.sender_id = u.id
        LEFT JOIN message_read_info mri ON m.id = mri.message_id
        LEFT JOIN user_last_read url ON true  
        WHERE m.chat_id = $3 
            AND m.is_deleted = false
    `

    if direction == "older" {
        if anchorTime.IsZero() {
            query = baseQuery + `
            GROUP BY 
                m.id, m.chat_id, m.sender_id, m.message_text, 
                m.message_type, m.reply_to_message_id, m.is_edited, 
                m.is_deleted, m.created_at, u.name, u.surname, 
                u.nickname, u.avatar_url
            ORDER BY m.created_at DESC
            LIMIT $4
            `
            args = []interface{}{userID, otherUserID, chatID, limit}
        } else {
            query = baseQuery + `
                AND m.created_at < $4
            GROUP BY 
                m.id, m.chat_id, m.sender_id, m.message_text, 
                m.message_type, m.reply_to_message_id, m.is_edited, 
                m.is_deleted, m.created_at, u.name, u.surname, 
                u.nickname, u.avatar_url
            ORDER BY m.created_at DESC
            LIMIT $5
            `
            args = []interface{}{userID, otherUserID, chatID, anchorTime, limit}
        }
    } else {
        query = baseQuery + `
            AND m.created_at >= $4
        GROUP BY 
            m.id, m.chat_id, m.sender_id, m.message_text, 
            m.message_type, m.reply_to_message_id, m.is_edited, 
            m.is_deleted, m.created_at, u.name, u.surname, 
            u.nickname, u.avatar_url
        ORDER BY m.created_at ASC
        LIMIT $5
        `
        args = []interface{}{userID, otherUserID, chatID, anchorTime, limit}
    }
    
    
    rows, err := r.DB.QueryContext(ctx, query, args...)
    if err != nil {
        return nil, fmt.Errorf("failed to execute query: %w", err)
    }
    defer rows.Close()
    
    var messages []*models.MessageDetail
    for rows.Next() {
        var message models.MessageDetail
        var replyToMessageID *string
        var senderName, senderSurname, senderNickname string
        var senderAvatarURL *string
        var isReadByCurrentUser, isReadByOtherUser bool
        var currentUserReadAt, otherUserReadAt sql.NullTime
        var currentUserLastRead, otherUserLastRead sql.NullTime
        
        message.Message = &models.Message{}
        
        err := rows.Scan(
            &message.ID,
            &message.ChatID,
            &message.SenderID,
            &message.MessageText,
            &message.MessageType,
            &replyToMessageID,
            &message.IsEdited,
            &message.IsDeleted,
            &message.CreatedAt,
            &senderName,
            &senderSurname,
            &senderNickname,
            &senderAvatarURL,
            &isReadByCurrentUser,
            &currentUserReadAt,
            &isReadByOtherUser,
            &otherUserReadAt,
            &currentUserLastRead,
            &otherUserLastRead,
        )
        if err != nil {
            return nil, fmt.Errorf("failed to scan message: %w", err)
        }
        
        message.ReplyToMessageID = replyToMessageID
        
        if message.SenderID == userID {
            if isReadByOtherUser {
                message.IsRead = true
                message.ReadAt = &otherUserReadAt.Time
            } else if otherUserLastRead.Valid && message.CreatedAt.Before(otherUserLastRead.Time) {
                message.IsRead = true
                message.ReadAt = &otherUserLastRead.Time
            } else {
                message.IsRead = false
            }
        } else {
            if isReadByCurrentUser {
                message.IsRead = true
                if currentUserReadAt.Valid {
                    message.ReadAt = &currentUserReadAt.Time
                }
            } else if currentUserLastRead.Valid && message.CreatedAt.Before(currentUserLastRead.Time) {
                message.IsRead = true
                message.ReadAt = &currentUserLastRead.Time
            } else {
                message.IsRead = false
            }
        }
        
        message.Sender = &models.UserDetail{
            Name:      senderName,
            Surname:   senderSurname,
            Nickname:  senderNickname,
            AvatarURL: senderAvatarURL,
        }
        
        messages = append(messages, &message)
    }
    
    return messages, nil
}
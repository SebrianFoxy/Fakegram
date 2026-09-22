package repositories

import (
	"context"
	"database/sql"
	"encoding/json"
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


func (r *MessageRepository) CreateMessage(ctx context.Context, chatID, senderID string, req *models.CreateMessageRequest) (string, error) {
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
    
    err := r.DB.QueryRowContext(ctx, query,
        chatID,        
        senderID,     
        req.MessageText, 
        req.MessageType, 
        replyTo,    
    ).Scan(&messageID, &isEdited, &isDeleted, &createdAt)

    if err != nil {
        return "", fmt.Errorf("failed to create private message: %w", err)
    }
    
    return messageID, nil
}

func (r *MessageRepository) GetMessagesByTimeRange(ctx context.Context, chatID, userID string, anchorTime time.Time, limit int, direction string) ([]*models.MessageDetail, error) {
	var query string
	var args []interface{}

	baseQuery := `
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
            m.updated_at,
            u.name as sender_name,
            u.surname as sender_surname,
            u.nickname as sender_nickname,
            u.avatar_url as sender_avatar_url,

            CASE WHEN my_read.message_id IS NOT NULL THEN true ELSE false END as is_my_read,
            my_read.read_at as my_read_at,

            other_read_info.read_at as other_read_at,
            COALESCE(other_read_info.read_count, 0) as other_read_count,

            next_other_read.read_at as next_other_read_time,
            next_my_read.read_at as next_my_read_time,

            COALESCE(read_by_info.read_by, '[]'::json) as read_by,

            rm.id as reply_id,
            rm.chat_id as reply_chat_id,
            rm.sender_id as reply_sender_id,
            rm.message_text as reply_message_text,
            rm.message_type as reply_message_type,
            rm.reply_to_message_id as reply_reply_to_message_id,
            rm.is_edited as reply_is_edited,
            rm.is_deleted as reply_is_deleted,
            rm.created_at as reply_created_at,
            ru.name as reply_sender_name,
            ru.surname as reply_sender_surname,
            ru.nickname as reply_sender_nickname,
            ru.avatar_url as reply_sender_avatar_url
        FROM messages m
        JOIN users u ON m.sender_id = u.id

        LEFT JOIN message_read_status my_read 
            ON m.id = my_read.message_id 
            AND my_read.user_id = $2::uuid

        LEFT JOIN LATERAL (
            SELECT 
                MAX(mrs2.read_at) as read_at,
                COUNT(*) as read_count
            FROM message_read_status mrs2
            WHERE mrs2.message_id = m.id
                AND mrs2.user_id != m.sender_id
        ) other_read_info ON true

        LEFT JOIN LATERAL (
            SELECT mrs2.read_at
            FROM message_read_status mrs2
            JOIN messages m2 ON m2.id = mrs2.message_id
            WHERE mrs2.user_id != $2::uuid
                AND m2.chat_id = $1
                AND m2.created_at >= m.created_at
            ORDER BY m2.created_at ASC, mrs2.read_at ASC
            LIMIT 1
        ) next_other_read ON true

        LEFT JOIN LATERAL (
            SELECT mrs2.read_at
            FROM message_read_status mrs2
            JOIN messages m2 ON m2.id = mrs2.message_id
            WHERE mrs2.user_id = $2::uuid
                AND m2.chat_id = $1
                AND m2.created_at >= m.created_at
            ORDER BY m2.created_at ASC
            LIMIT 1
        ) next_my_read ON true

        LEFT JOIN LATERAL (
            SELECT 
                json_agg(
                    json_build_object(
                        'user_id', ru2.id,
                        'name', ru2.name,
                        'surname', ru2.surname,
                        'nickname', ru2.nickname,
                        'avatar_url', ru2.avatar_url,
                        'read_at', read_data.read_at
                    ) ORDER BY read_data.read_at ASC
                ) as read_by
            FROM (
                SELECT DISTINCT ON (user_id)
                    user_id,
                    read_at
                FROM (
                    SELECT 
                        mrs3.user_id, 
                        mrs3.read_at
                    FROM message_read_status mrs3
                    WHERE mrs3.message_id = m.id
                        AND mrs3.user_id != m.sender_id
                    
                    UNION ALL
                    
                    SELECT 
                        mrs4.user_id, 
                        mrs4.read_at
                    FROM message_read_status mrs4
                    JOIN messages m4 ON m4.id = mrs4.message_id
                    JOIN LATERAL (
                        SELECT MIN(m5.created_at) as first_read_at
                        FROM message_read_status mrs5
                        JOIN messages m5 ON m5.id = mrs5.message_id
                        WHERE m5.chat_id = $1
                            AND m5.created_at >= m.created_at
                            AND mrs5.user_id = mrs4.user_id
                    ) first_read ON true
                    WHERE m4.chat_id = $1
                        AND m4.created_at >= m.created_at
                        AND m4.created_at = first_read.first_read_at
                        AND mrs4.user_id != m.sender_id
                ) all_reads
                ORDER BY user_id, read_at ASC
            ) read_data
            JOIN users ru2 ON ru2.id = read_data.user_id
        ) read_by_info ON true

        LEFT JOIN messages rm ON m.reply_to_message_id = rm.id
        LEFT JOIN users ru ON rm.sender_id = ru.id
        WHERE m.chat_id = $1 
            AND m.is_deleted = false
	`

	if direction == "older" {
		if anchorTime.IsZero() {
			query = baseQuery + `
				ORDER BY m.created_at DESC
				LIMIT $3
			`
			args = []interface{}{chatID, userID, limit}
		} else {
			query = baseQuery + `
				AND m.created_at < $3
				ORDER BY m.created_at DESC
				LIMIT $4
			`
			args = []interface{}{chatID, userID, anchorTime, limit}
		}
	} else {
		if anchorTime.IsZero() {
			query = baseQuery + `
				ORDER BY m.created_at ASC
				LIMIT $3
			`
			args = []interface{}{chatID, userID, limit}
		} else {
			query = baseQuery + `
				AND m.created_at >= $3
				ORDER BY m.created_at ASC
				LIMIT $4
			`
			args = []interface{}{chatID, userID, anchorTime, limit}
		}
	}

	rows, err := r.DB.QueryContext(ctx, query, args...)
	if err != nil {
		return nil, fmt.Errorf("failed to get messages: %w", err)
	}
	defer rows.Close()

	var messages []*models.MessageDetail
	for rows.Next() {
		var msg models.Message
		var replyToMessageID sql.NullString
		var updatedAt sql.NullTime
		var senderName, senderSurname, senderNickname string
		var senderAvatarURL sql.NullString

		var isMyRead bool
		var myReadAt sql.NullTime
		var otherReadAt sql.NullTime
		var otherReadCount int
		var nextOtherReadTime, nextMyReadTime sql.NullTime
		var readByJSON sql.NullString

		var replyID sql.NullString
		var replyChatID sql.NullString
		var replySenderID sql.NullString
		var replyMessageText sql.NullString
		var replyMessageType sql.NullString
		var replyReplyToMessageID sql.NullString
		var replyIsEdited sql.NullBool
		var replyIsDeleted sql.NullBool
		var replyCreatedAt sql.NullTime
		var replySenderName sql.NullString
		var replySenderSurname sql.NullString
		var replySenderNickname sql.NullString
		var replySenderAvatarURL sql.NullString

		err := rows.Scan(
			&msg.ID,
			&msg.ChatID,
			&msg.SenderID,
			&msg.MessageText,
			&msg.MessageType,
			&replyToMessageID,
			&msg.IsEdited,
			&msg.IsDeleted,
			&msg.CreatedAt,
			&updatedAt,
			&senderName,
			&senderSurname,
			&senderNickname,
			&senderAvatarURL,
			&isMyRead,
			&myReadAt,
			&otherReadAt,
			&otherReadCount,
			&nextOtherReadTime,
			&nextMyReadTime,
			&readByJSON,
			&replyID,
			&replyChatID,
			&replySenderID,
			&replyMessageText,
			&replyMessageType,
			&replyReplyToMessageID,
			&replyIsEdited,
			&replyIsDeleted,
			&replyCreatedAt,
			&replySenderName,
			&replySenderSurname,
			&replySenderNickname,
			&replySenderAvatarURL,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan message: %w", err)
		}

		if replyToMessageID.Valid {
			msg.ReplyToMessageID = &replyToMessageID.String
		}
		if updatedAt.Valid {
			msg.UpdatedAt = updatedAt.Time
		}

		var readBy []*models.MessageReadInfo
		if readByJSON.Valid && readByJSON.String != "" && readByJSON.String != "[]" {
			if err := json.Unmarshal([]byte(readByJSON.String), &readBy); err != nil {
				log.Printf("Failed to parse read_by JSON: %v", err)
			}
		}

		var finalIsRead bool
		var readAtPtr *time.Time

		if msg.SenderID == userID {
			if otherReadCount > 0 && otherReadAt.Valid {
				finalIsRead = true
				readAtPtr = &otherReadAt.Time
			} else if nextOtherReadTime.Valid {
				finalIsRead = true
				readAtPtr = &nextOtherReadTime.Time
			} else {
				finalIsRead = false
			}
		} else {
			if isMyRead && myReadAt.Valid {
				finalIsRead = true
				readAtPtr = &myReadAt.Time
			} else if nextMyReadTime.Valid {
				finalIsRead = true
				readAtPtr = &nextMyReadTime.Time
			} else {
				finalIsRead = false
			}
		}

		sender := &models.UserDetail{
			Name:      senderName,
			Surname:   senderSurname,
			Nickname:  senderNickname,
		}
		if senderAvatarURL.Valid {
			sender.AvatarURL = &senderAvatarURL.String
		}

		msgDetail := &models.MessageDetail{
			Message:   &msg,
			IsRead:    finalIsRead,
			ReadAt:    readAtPtr,
			ReadBy:    readBy,
			Sender:    sender,
		}

		if replyID.Valid {
			replyMsg := &models.Message{
				ID:          replyID.String,
				ChatID:      replyChatID.String,
				SenderID:    replySenderID.String,
				MessageText: replyMessageText.String,
				MessageType: models.MessageType(replyMessageType.String),
				IsEdited:    replyIsEdited.Bool,
				IsDeleted:   replyIsDeleted.Bool,
			}

			if replyReplyToMessageID.Valid {
				replyMsg.ReplyToMessageID = &replyReplyToMessageID.String
			}
			if replyCreatedAt.Valid {
				replyMsg.CreatedAt = replyCreatedAt.Time
			}

			replyDetail := &models.MessageDetail{
				Message: replyMsg,
				Sender: &models.UserDetail{
					Name:      replySenderName.String,
					Surname:   replySenderSurname.String,
					Nickname:  replySenderNickname.String,
				},
			}
			if replySenderAvatarURL.Valid {
				replyDetail.Sender.AvatarURL = &replySenderAvatarURL.String
			}

			msgDetail.ReplyToMessage = replyDetail
		}

		messages = append(messages, msgDetail)
	}

	return messages, nil
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
            m.updated_at,
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
    
    var msg models.Message 
	var replyToMessageID sql.NullString
	var updatedAt sql.NullTime
	var senderName, senderSurname, senderNickname string
	var senderAvatarURL sql.NullString
	var isRead bool
	var readAt sql.NullTime

	err := r.DB.QueryRowContext(ctx, query, messageID, userID).Scan(
		&msg.ID,           
		&msg.ChatID,      
		&msg.SenderID,     
		&msg.MessageText,  
		&msg.MessageType,  
		&replyToMessageID,
		&msg.IsEdited,     
		&msg.IsDeleted,    
		&msg.CreatedAt,
		&updatedAt,
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
    
    sender := &models.UserDetail{
		Name:      senderName,
		Surname:   senderSurname,
		Nickname:  senderNickname,
	}
	if senderAvatarURL.Valid {
		sender.AvatarURL = &senderAvatarURL.String
	}
    
    var readAtPtr *time.Time
	if readAt.Valid {
		readAtPtr = &readAt.Time
	}

	msgDetail := &models.MessageDetail{
		Message: &msg,  
		IsRead:  isRead,
		ReadAt:  readAtPtr,
		Sender:  sender,
	}
    
    if replyToMessageID.Valid && replyToMessageID.String != "" {
		replyMsgDetail, err := r.GetMessageDetailByID(ctx, replyToMessageID.String, userID)
		if err != nil {
			log.Printf("Failed to load reply message: %v", err)
		} else {
			msgDetail.ReplyToMessage = replyMsgDetail
		}
	}

	return msgDetail, nil
}

func (r *MessageRepository) GetMessageTime(ctx context.Context, messageID, chatID string) (time.Time, error) {
	query := `
		SELECT created_at 
		FROM messages 
		WHERE id = $1 AND chat_id = $2 AND NOT is_deleted
	`

	var messageTime time.Time
	err := r.DB.QueryRowContext(ctx, query, messageID, chatID).Scan(&messageTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return time.Time{}, fmt.Errorf("message not found in this chat")
		}
		return time.Time{}, fmt.Errorf("failed to get message time: %w", err)
	}

	return messageTime, nil
}

func (r *MessageRepository) MarkMessageAsRead(ctx context.Context, messageID, userID string, readAt time.Time,) error {
    tx, err := r.DB.BeginTx(ctx, nil)
    if err != nil {
        return fmt.Errorf("begin tx: %w", err)
    }
    defer tx.Rollback()

    const insertStatus = `
        INSERT INTO message_read_status (message_id, user_id, read_at)
        VALUES ($1::uuid, $2::uuid, $3)
        ON CONFLICT (message_id, user_id)
        DO UPDATE SET read_at = EXCLUDED.read_at
        WHERE message_read_status.read_at < EXCLUDED.read_at;
    `
    if _, err := tx.ExecContext(ctx, insertStatus, messageID, userID, readAt); err != nil {
        return fmt.Errorf("insert read status: %w", err)
    }

    const bumpCursor = `
        UPDATE chat_members cm
        SET last_read_seq = GREATEST(COALESCE(cm.last_read_seq, 0), m.seq)
        FROM messages m
        WHERE m.id = $1::uuid
			AND cm.chat_id = m.chat_id
			AND cm.user_id = $2::uuid
			AND m.sender_id != $2::uuid
			AND NOT m.is_deleted;
    `
    if _, err := tx.ExecContext(ctx, bumpCursor, messageID, userID); err != nil {
        return fmt.Errorf("bump cursor: %w", err)
    }

    return tx.Commit()
}

func (r *MessageRepository) GetLastMessageFromOthersUser(ctx context.Context, chatID, excludeUserID string) (*models.Message, error) {
	query := `
		SELECT 
			id, chat_id, sender_id, message_text, message_type,
			reply_to_message_id, is_edited, is_deleted, created_at, updated_at
		FROM messages 
		WHERE chat_id = $1 AND is_deleted = false AND sender_id != $2
		ORDER BY created_at DESC 
		LIMIT 1
	`

	var msg models.Message
	var replyToMessageID sql.NullString
	var updatedAt sql.NullTime

	err := r.DB.QueryRowContext(ctx, query, chatID, excludeUserID).Scan(
		&msg.ID,
		&msg.ChatID,
		&msg.SenderID,
		&msg.MessageText,
		&msg.MessageType,
		&replyToMessageID,
		&msg.IsEdited,
		&msg.IsDeleted,
		&msg.CreatedAt,
		&updatedAt,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to get last message: %w", err)
	}

	if replyToMessageID.Valid {
		msg.ReplyToMessageID = &replyToMessageID.String
	}
	if updatedAt.Valid {
		msg.UpdatedAt = updatedAt.Time
	}

	return &msg, nil
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
    const query = `
        SELECT COUNT(*)
        FROM messages m
        JOIN chat_members cm
			ON cm.chat_id = m.chat_id
			AND cm.user_id = $1::uuid
		WHERE m.chat_id = $2
			AND m.sender_id != $1::uuid
			AND NOT m.is_deleted
			AND m.seq > COALESCE(cm.last_read_seq, 0);
    `
    var count int
    if err := r.DB.QueryRowContext(ctx, query, userID, chatID).Scan(&count); err != nil {
        return 0, fmt.Errorf("get unread count: %w", err)
    }
    return count, nil
}

func (r *MessageRepository) GetUnreadCountsForChat(ctx context.Context, chatID string,) (map[string]int, error) {
    const query = `
        SELECT cm.user_id, COUNT(m.id) AS unread
        FROM chat_members cm
        LEFT JOIN messages m
            ON m.chat_id = cm.chat_id
			AND m.sender_id != cm.user_id
			AND NOT m.is_deleted
			AND m.seq > COALESCE(cm.last_read_seq, 0)
        WHERE cm.chat_id = $1
        GROUP BY cm.user_id;
    `
    rows, err := r.DB.QueryContext(ctx, query, chatID)
    if err != nil {
        return nil, fmt.Errorf("get unread counts for chat: %w", err)
    }
    defer rows.Close()

    result := make(map[string]int)
    for rows.Next() {
        var userID string
        var count int
        if err := rows.Scan(&userID, &count); err != nil {
            return nil, fmt.Errorf("scan unread count: %w", err)
        }
        result[userID] = count
    }
    if err := rows.Err(); err != nil {
        return nil, fmt.Errorf("iterate unread counts: %w", err)
    }
    return result, nil
}

func (r *MessageRepository) DeleteMessage(ctx context.Context, userID, chatID, messageID string) error {
    query := `
		UPDATE messages 
		SET is_deleted = true, 
			updated_at = NOW()
		WHERE id = $1 
			AND sender_id = $2 
			AND is_deleted = false
	`

	result, err := r.DB.ExecContext(ctx, query, messageID, userID)
	if err != nil {
		return fmt.Errorf("failed to delete message: %w", err)
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("failed to check affected rows: %w", err)
	}

	if rowsAffected == 0 {
		return fmt.Errorf("message not found or you don't have permission to delete it")
	}

    log.Printf("Message %s deleted by user %s in chat %s", messageID, userID, chatID)

	return nil
}

func (r *MessageRepository) EditMessage(ctx context.Context, messageID, newText string) (*models.Message, error) {
    query := `
        UPDATE messages 
        SET message_text = $1, 
            is_edited = true, 
            updated_at = NOW() 
        WHERE id = $2 AND is_deleted = false
        RETURNING id, chat_id, sender_id, message_text, message_type, 
                reply_to_message_id, is_edited, is_deleted, created_at, updated_at
    `

    var updatedMessage models.Message
    err := r.DB.QueryRowContext(ctx, query, 
        newText, 
        messageID,
    ).Scan(
        &updatedMessage.ID,
        &updatedMessage.ChatID,
        &updatedMessage.SenderID,
        &updatedMessage.MessageText,
        &updatedMessage.MessageType,
        &updatedMessage.ReplyToMessageID,
        &updatedMessage.IsEdited,
        &updatedMessage.IsDeleted,
        &updatedMessage.CreatedAt,
        &updatedMessage.UpdatedAt,
    )

    if err != nil {
        if err == sql.ErrNoRows {
            return nil, models.ErrMessageNotFound
        }
        return nil, fmt.Errorf("failed to update message: %w", err)
    }

    return &updatedMessage, nil
}

func (r *MessageRepository) GetLastReadTime(ctx context.Context, chatID, userID string) (*time.Time, error) {
	query := `
		SELECT MAX(mrs.read_at)
		FROM message_read_status mrs
		JOIN messages m ON m.id = mrs.message_id
		WHERE mrs.user_id = $1 AND m.chat_id = $2
	`

	var lastReadTime sql.NullTime
	err := r.DB.QueryRowContext(ctx, query, userID, chatID).Scan(&lastReadTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to get last read time: %w", err)
	}

	if lastReadTime.Valid {
		return &lastReadTime.Time, nil
	}

	return nil, nil
}

func (r *MessageRepository) GetFirstUnreadTime(ctx context.Context, chatID, userID string, afterTime time.Time) (*time.Time, error) {
    query := `
		SELECT MIN(m.created_at)
		FROM messages m
		LEFT JOIN message_read_status mrs ON m.id = mrs.message_id AND mrs.user_id = $2
		WHERE m.chat_id = $1 
			AND m.is_deleted = false
			AND m.sender_id != $2
			AND mrs.message_id IS NULL
			AND m.created_at > $3
	`

	var firstUnreadTime sql.NullTime
	err := r.DB.QueryRowContext(ctx, query, chatID, userID, afterTime).Scan(&firstUnreadTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to get first unread time: %w", err)
	}

	if firstUnreadTime.Valid {
		return &firstUnreadTime.Time, nil
	}

	return nil, nil
}

func (r *MessageRepository) GetLastUserMessageTime(ctx context.Context, chatID, userID string) (*time.Time, error) {
	query := `
		SELECT MAX(created_at) 
		FROM messages 
		WHERE chat_id = $1 
			AND is_deleted = false 
			AND sender_id = $2
	`

	var lastTime sql.NullTime
	err := r.DB.QueryRowContext(ctx, query, chatID, userID).Scan(&lastTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil 
		}
		return nil, fmt.Errorf("failed to get last user message time: %w", err)
	}

	if lastTime.Valid {
		return &lastTime.Time, nil
	}

	return nil, nil
}

func (r *MessageRepository) GetLastMessageTime(ctx context.Context, chatID string) (*time.Time, error) {
	query := `
		SELECT MAX(created_at) 
		FROM messages 
		WHERE chat_id = $1 
			AND is_deleted = false
	`

	var lastTime sql.NullTime
	err := r.DB.QueryRowContext(ctx, query, chatID).Scan(&lastTime)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to get last message time: %w", err)
	}

	if lastTime.Valid {
		return &lastTime.Time, nil
	}

	return nil, nil
}

func (r *MessageRepository) HasOlderMessages(ctx context.Context, chatID string, beforeTime time.Time) (bool, error) {
	var exists bool
	err := r.DB.QueryRowContext(ctx, `
		SELECT EXISTS(
			SELECT 1 FROM messages 
			WHERE chat_id = $1 
				AND is_deleted = false 
				AND created_at < $2
		)
	`, chatID, beforeTime).Scan(&exists)
	
	if err != nil {
		return false, fmt.Errorf("failed to check older messages: %w", err)
	}
	
	return exists, nil
}

func (r *MessageRepository) HasNewerMessages(ctx context.Context, chatID string, afterTime time.Time) (bool, error) {
	var exists bool
	err := r.DB.QueryRowContext(ctx, `
		SELECT EXISTS(
			SELECT 1 FROM messages 
			WHERE chat_id = $1 
				AND is_deleted = false 
				AND created_at > $2
		)
	`, chatID, afterTime).Scan(&exists)
	
	if err != nil {
		return false, fmt.Errorf("failed to check newer messages: %w", err)
	}
	
	return exists, nil
}


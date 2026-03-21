package repositories

import (
	"context"
	"database/sql"
	"fakegram-api/internal/models"
	"fmt"
	"log"
)

type ChatRepository struct {
    DB *sql.DB
}

func NewChatRepository(db *sql.DB) *ChatRepository {
    return &ChatRepository{DB: db}
}

func (r *ChatRepository) IsUserInDialog(ctx context.Context, chatID, userID string) (bool, error) {
    user1, user2, err := models.ExtractUsersFromChatID(chatID)
    if err != nil {
        return false, fmt.Errorf("invalid chat ID: %w", err)
    }
    
    return userID == user1 || userID == user2, nil
}

func (r *ChatRepository) GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error) {
    query := `
        WITH UserDialogs AS (
            SELECT DISTINCT chat_id
            FROM messages 
            WHERE sender_id = $1 OR chat_id LIKE $2
        ),
        LastMessages AS (
            SELECT DISTINCT ON (m.chat_id) 
                m.chat_id,
                m.id as message_id,
                m.sender_id,
                m.message_text,
                m.message_type,
                m.is_edited,
                m.is_deleted,
                m.created_at
            FROM messages m
            WHERE m.chat_id IN (SELECT chat_id FROM UserDialogs)
            ORDER BY m.chat_id, m.created_at DESC
        ),
        LastReadTimePerChat AS (
            SELECT 
                m.chat_id,
                MAX(m.created_at) as last_read_time
            FROM message_read_status mrs
            JOIN messages m ON m.id = mrs.message_id
            WHERE mrs.user_id = $1
            GROUP BY m.chat_id
        ),
        UnreadCounts AS (
            SELECT 
                m.chat_id,
                COUNT(*) as unread_count
            FROM messages m
            LEFT JOIN LastReadTimePerChat lr ON m.chat_id = lr.chat_id
            WHERE m.chat_id IN (SELECT chat_id FROM UserDialogs)
                AND m.sender_id != $1
                AND NOT m.is_deleted
                AND (lr.last_read_time IS NULL OR m.created_at > lr.last_read_time)
            GROUP BY m.chat_id
        )
        SELECT 
            lm.chat_id as id,
            'private' as chat_type,
            lm.message_id,
            lm.sender_id,
            lm.message_text,
            lm.message_type,
            lm.is_edited,
            lm.is_deleted,
            lm.created_at as message_created_at,
            lm.created_at as updated_at,
            COALESCE(uc.unread_count, 0) as unread_count
        FROM LastMessages lm
        LEFT JOIN UnreadCounts uc ON lm.chat_id = uc.chat_id
        ORDER BY lm.created_at DESC
    `
    
    searchPattern := "%" + userID + "%"
    rows, err := r.DB.QueryContext(ctx, query, userID, searchPattern)
    if err != nil {
        return nil, fmt.Errorf("failed to get user chats: %w", err)
    }
    defer rows.Close()

    var chats []*models.ChatListItem
    for rows.Next() {
        var chat models.ChatListItem
        var lastMessage models.Message
        
        err := rows.Scan(
            &chat.ID,
            &chat.ChatType,
            &lastMessage.ID,
            &lastMessage.SenderID,
            &lastMessage.MessageText,
            &lastMessage.MessageType,
            &lastMessage.IsEdited,
            &lastMessage.IsDeleted,
            &lastMessage.CreatedAt,
            &chat.UpdatedAt,
            &chat.UnreadCount,
        )
        if err != nil {
            return nil, fmt.Errorf("failed to scan chat: %w", err)
        }

        if lastMessage.ID != "" {
            chat.LastMessage = &lastMessage
        }

        otherUserID, err := models.GetOtherUserID(chat.ID, userID)
        if err != nil {
            return nil, fmt.Errorf("failed to get other user ID: %w", err)
        }

        otherUser, err := r.getChatUserInfo(ctx, otherUserID)
        if err != nil {
            return nil, fmt.Errorf("failed to get other user info: %w", err)
        }
        chat.OtherUser = otherUser
        chat.Title = otherUser.Name + " " + otherUser.Surname

        chats = append(chats, &chat)
    }

    return chats, nil
}

func (r *ChatRepository) getChatUserInfo(ctx context.Context, userID string) (*models.User, error) {
    log.Printf("🔍 getChatUserInfo called for user: %s", userID)
    
	query := `
		SELECT id, name, surname, nickname, avatar_url, is_online
		FROM users 
		WHERE id = $1
	`

	var user models.User
	err := r.DB.QueryRowContext(ctx, query, userID).Scan(
		&user.ID,
		&user.Name,
		&user.Surname,
		&user.Nickname,
		&user.AvatarURL,
		&user.IsOnline,
	)
	if err != nil {
		return nil, fmt.Errorf("failed to get user info: %w", err)
	}

	return &user, nil
}

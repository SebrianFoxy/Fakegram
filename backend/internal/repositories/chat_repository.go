package repositories

import (
	"context"
	"database/sql"
	"fakegram-api/internal/models"
	"fmt"
	"log"
	"time"
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
            -- Личные чаты из сообщений
            SELECT DISTINCT chat_id
            FROM messages 
            WHERE sender_id = $1 OR chat_id LIKE $2
            
            UNION
            
            -- Групповые чаты
            SELECT chat_id
            FROM chat_members
            WHERE user_id = $1
        ),
        LastMessages AS (
            SELECT DISTINCT ON (m.chat_id) 
                m.chat_id,
                m.id as message_id,
                m.sender_id as sender_id,
                m.message_text,
                m.message_type,
                m.is_edited,
                m.is_deleted,
                m.created_at,
                m.updated_at
            FROM messages m
            WHERE m.chat_id IN (SELECT chat_id FROM UserDialogs)
                AND NOT m.is_deleted
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
            lm.message_id,
            lm.sender_id,
            lm.message_text,
            lm.message_type,
            lm.is_edited,
            lm.is_deleted,
            lm.created_at as message_created_at,
            lm.created_at,
            lm.updated_at,
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
        var chatID, messageID, senderID, messageText, messageType string
        var isEdited, isDeleted bool
        var messageCreatedAt, createdAt, updatedAt time.Time
        var unreadCount int
        
        err := rows.Scan(
            &chatID,
            &messageID,
            &senderID,
            &messageText,
            &messageType,
            &isEdited,
            &isDeleted,
            &messageCreatedAt,
            &createdAt,
            &updatedAt,
            &unreadCount,
        )
        if err != nil {
            return nil, fmt.Errorf("failed to scan chat: %w", err)
        }

        chat, err := r.buildChatListItem(ctx, chatID, userID)
        if err != nil {
            log.Printf("Warning: failed to build chat item for %s: %v", chatID, err)
            continue
        }

        if messageID != "" {
            chat.LastMessage = &models.Message{
                ID:          messageID,
                SenderID:    senderID,
                MessageText: messageText,
                MessageType: models.MessageType("text"),
                IsEdited:    isEdited,
                IsDeleted:   isDeleted,
                CreatedAt:   messageCreatedAt,
                UpdatedAt:   updatedAt,
            }
        }
        
        chat.UnreadCount = unreadCount
        
        if !updatedAt.IsZero() {
            chat.UpdatedAt = updatedAt
        } else {
            chat.UpdatedAt = createdAt
        }

        chats = append(chats, chat)
    }

    return chats, nil
}

func (r *ChatRepository) SearchChatByNickname(ctx context.Context, query string, currentUserID string, limit, offset int) ([]*models.ChatListItem, error) {
	searchPattern := "%" + query + "%"
	
	sqlQuery := `
		(
			SELECT 
				id as entity_id,
				'private' as chat_type,
				CONCAT(name, ' ', surname) as title,
				avatar_url,
				nickname,
				is_online,
				name,
				surname,
				bio,
				CASE 
					WHEN LOWER(nickname) = LOWER($2) THEN 0
					WHEN LOWER(nickname) LIKE LOWER($3) THEN 1
					WHEN LOWER(name) LIKE LOWER($2) OR LOWER(surname) LIKE LOWER($2) THEN 2
					ELSE 3
				END as relevance
			FROM users 
			WHERE 
				(LOWER(nickname) LIKE LOWER($1) 
				OR LOWER(name) LIKE LOWER($1) 
				OR LOWER(surname) LIKE LOWER($1))
				AND id != $4
			
			UNION ALL
			
			SELECT 
				c.id as entity_id,
				'group' as chat_type,
				COALESCE(c.title, 'Group Chat') as title,
				c.avatar_url,
				'' as nickname,
				FALSE as is_online,
				'' as name,
				'' as surname,
				COALESCE(c.description, '') as bio,
				CASE 
					WHEN LOWER(COALESCE(c.title, '')) = LOWER($2) THEN 0
					WHEN LOWER(COALESCE(c.title, '')) LIKE LOWER($3) THEN 1
					WHEN LOWER(COALESCE(c.description, '')) LIKE LOWER($1) THEN 2
					ELSE 3
				END as relevance
			FROM chats c
			WHERE 
				c.chat_type = 'group'
				AND (
					LOWER(COALESCE(c.title, '')) LIKE LOWER($1)
					OR LOWER(COALESCE(c.description, '')) LIKE LOWER($1)
				)
		)
		ORDER BY 
			relevance ASC,
			chat_type ASC,
			title ASC
		LIMIT $5 OFFSET $6
	`
	
	rows, err := r.DB.QueryContext(ctx, sqlQuery, 
		searchPattern, query, query+"%", currentUserID, limit, offset)
	if err != nil {
		return nil, fmt.Errorf("failed to search chats: %w", err)
	}
	defer rows.Close()

	var chats []*models.ChatListItem
	for rows.Next() {
		var entityID, chatTypeStr, title string
		var avatarURL, nickname, name, surname, bio sql.NullString
		var isOnline sql.NullBool
		var relevance int
		
		err := rows.Scan(
			&entityID,
			&chatTypeStr,
			&title,
			&avatarURL,
			&nickname,
			&isOnline,
			&name,
			&surname,
			&bio,
			&relevance,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan search result: %w", err)
		}

		var chat *models.ChatListItem
		
		if chatTypeStr == "group" {
			chat, err = r.buildChatListItem(ctx, entityID, currentUserID)
		} else {
			privateChatID := models.GenerateChatID(currentUserID, entityID)
			chat, err = r.buildChatListItem(ctx, privateChatID, currentUserID)
		}
		
		if err != nil {
			log.Printf("Warning: failed to build chat item: %v", err)
			continue
		}

		chats = append(chats, chat)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating search results: %w", err)
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

func (r *ChatRepository) buildChatListItem(ctx context.Context, chatID, currentUserID string) (*models.ChatListItem, error) {
	if models.IsPrivateChat(chatID) {
		return r.buildPrivateChatItem(ctx, chatID, currentUserID)
	}
	return r.buildGroupChatItem(ctx, chatID)
}

func (r *ChatRepository) buildPrivateChatItem(ctx context.Context, chatID, currentUserID string) (*models.ChatListItem, error) {
	otherUserID, err := models.GetOtherUserID(chatID, currentUserID)
	if err != nil {
		return nil, fmt.Errorf("failed to get other user ID: %w", err)
	}

	otherUser, err := r.getChatUserInfo(ctx, otherUserID)
	if err != nil {
		return nil, fmt.Errorf("failed to get other user info: %w", err)
	}

    if otherUser == nil {
		return nil, fmt.Errorf("other user not found: %s", otherUserID)
	}

    avatarURL := ""
	if otherUser.AvatarURL != nil {
		avatarURL = *otherUser.AvatarURL
	}

	chat := &models.ChatListItem{
		ID:        chatID,
		ChatType:  models.ChatTypePrivate,
		Title:     otherUser.Name + " " + otherUser.Surname,
		AvatarURL: avatarURL,
		OtherUser: otherUser,
	}

	r.enrichWithLastMessage(ctx, chat)

	return chat, nil
}

func (r *ChatRepository) buildGroupChatItem(ctx context.Context, chatID string) (*models.ChatListItem, error) {
	query := `
		SELECT 
			COALESCE(title, 'Group Chat') as title,
			avatar_url,
			created_at
		FROM chats
		WHERE id = $1 AND chat_type = 'group'
	`

	var title, avatarURL sql.NullString
	var createdAt time.Time

	err := r.DB.QueryRowContext(ctx, query, chatID).Scan(&title, &avatarURL, &createdAt)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("group chat not found")
		}
		return nil, fmt.Errorf("failed to get group info: %w", err)
	}

	chat := &models.ChatListItem{
		ID:       chatID,
		ChatType: models.ChatTypeGroup,
	}

	if title.Valid {
		chat.Title = title.String
	}
	if avatarURL.Valid {
		chat.AvatarURL = avatarURL.String
	}

	// members, err := r.getGroupChatMembers(ctx, chatID)
	// if err != nil {
	// 	log.Printf("Warning: failed to get group members for %s: %v", chatID, err)
	// } else {
	// 	chat.Members = members
	// }

	r.enrichWithLastMessage(ctx, chat)

	if chat.UpdatedAt.IsZero() {
		chat.UpdatedAt = createdAt
	}

	return chat, nil
}

func (r *ChatRepository) enrichWithLastMessage(ctx context.Context, chat *models.ChatListItem) {
	lastMsg, err := r.getLastMessageForChat(ctx, chat.ID)
	if err != nil {
		log.Printf("Warning: failed to get last message for %s: %v", chat.ID, err)
		return
	}
	
	if lastMsg != nil {
		chat.LastMessage = lastMsg
		chat.UpdatedAt = lastMsg.CreatedAt
	}
}

func (r *ChatRepository) getLastMessageForChat(ctx context.Context, chatID string) (*models.Message, error) {
	query := `
		SELECT 
			id,
			sender_id,
			message_text,
			message_type,
			is_edited,
			is_deleted,
			created_at,
			updated_at
		FROM messages
		WHERE chat_id = $1 AND is_deleted = false
		ORDER BY created_at DESC
		LIMIT 1
	`
	
	var msg models.Message
	var messageText, messageType sql.NullString
	
	err := r.DB.QueryRowContext(ctx, query, chatID).Scan(
		&msg.ID,
		&msg.SenderID,
		&messageText,
		&messageType,
		&msg.IsEdited,
		&msg.IsDeleted,
		&msg.CreatedAt,
		&msg.UpdatedAt,
	)
	
	if err == sql.ErrNoRows {
		return nil, nil
	}
	
	if err != nil {
		return nil, fmt.Errorf("failed to get last message: %w", err)
	}
	
	if messageText.Valid {
		msg.MessageText = messageText.String
	}
	
	if messageType.Valid {
		msg.MessageType = models.MessageType(messageType.String)
	}
	
	return &msg, nil
}


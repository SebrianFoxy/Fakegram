package repositories

import (
	"context"
	"database/sql"
	"fakegram-api/internal/models"
	"fmt"
	"time"

	"github.com/lib/pq"
)

type ChatRepository struct {
    DB *sql.DB
}

func NewChatRepository(db *sql.DB) *ChatRepository {
    return &ChatRepository{DB: db}
}

func (r *ChatRepository) GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error) {
	query := `
		WITH UserDialogs AS (
			SELECT cm.chat_id
			FROM chat_members cm
			WHERE cm.user_id = $1::uuid
			AND (
				(
				cm.chat_id LIKE 'private_%'
				AND EXISTS (
					SELECT 1 FROM messages m
					WHERE m.chat_id = cm.chat_id
						AND NOT m.is_deleted
				)
				)
				OR
				(
				cm.chat_id NOT LIKE 'private_%'
				AND EXISTS (
					SELECT 1 FROM chats c
					WHERE c.id::text = cm.chat_id
						AND c.is_deleted = FALSE
				)
				)
			)
		),
		LastMessages AS (
			SELECT DISTINCT ON (m.chat_id)
				m.chat_id,
				m.id AS message_id,
				m.sender_id,
				m.message_text,
				m.message_type,
				m.is_edited,
				m.is_deleted,
				m.created_at,
				m.updated_at
			FROM messages m
			WHERE m.chat_id IN (SELECT chat_id FROM UserDialogs)
			AND NOT m.is_deleted
			ORDER BY m.chat_id, m.seq DESC
		),
		UnreadCounts AS (
			SELECT
				cm.chat_id,
				COUNT(m.id) AS unread_count
			FROM chat_members cm
			LEFT JOIN messages m
				ON m.chat_id = cm.chat_id
			AND m.sender_id != cm.user_id
			AND NOT m.is_deleted
			AND m.seq > COALESCE(cm.last_read_seq, 0)
			WHERE cm.user_id = $1::uuid
			GROUP BY cm.chat_id
		),
		PrivateChatUsers AS (
			SELECT
				ud.chat_id,
				u.id AS other_user_id,
				u.name AS other_user_name,
				u.surname AS other_user_surname,
				u.nickname AS other_user_nickname,
				u.avatar_url AS other_user_avatar_url,
				u.is_online AS other_user_is_online
			FROM UserDialogs ud
			JOIN users u ON u.id = (
				CASE
					WHEN split_part(regexp_replace(ud.chat_id, '^private_', ''), '_', 1)::uuid = $1::uuid
						THEN split_part(regexp_replace(ud.chat_id, '^private_', ''), '_', 2)::uuid
					ELSE split_part(regexp_replace(ud.chat_id, '^private_', ''), '_', 1)::uuid
				END
			)
			WHERE ud.chat_id LIKE 'private_%'
		),
		GroupChatsInfo AS (
			SELECT
				c.id::text AS chat_id,
				COALESCE(c.title, 'Group Chat') AS group_title,
				c.avatar_url AS group_avatar_url,
				c.created_at AS group_created_at
			FROM chats c
			WHERE c.id::text IN (SELECT chat_id FROM UserDialogs)
			AND c.is_deleted = FALSE
		)
		SELECT
			ud.chat_id AS id,
			lm.message_id,
			lm.sender_id,
			lm.message_text,
			lm.message_type,
			lm.is_edited,
			lm.is_deleted,
			lm.created_at AS message_created_at,
			lm.updated_at AS message_updated_at,
			COALESCE(uc.unread_count, 0) AS unread_count,
			pcu.other_user_id,
			pcu.other_user_name,
			pcu.other_user_surname,
			pcu.other_user_nickname,
			pcu.other_user_avatar_url,
			pcu.other_user_is_online,
			gci.group_title,
			gci.group_avatar_url
		FROM UserDialogs ud
		LEFT JOIN LastMessages lm ON ud.chat_id = lm.chat_id
		LEFT JOIN UnreadCounts uc ON ud.chat_id = uc.chat_id
		LEFT JOIN PrivateChatUsers pcu ON ud.chat_id = pcu.chat_id
		LEFT JOIN GroupChatsInfo gci ON ud.chat_id = gci.chat_id
		ORDER BY COALESCE(lm.created_at, gci.group_created_at, '1970-01-01'::timestamptz) DESC
	`

	rows, err := r.DB.QueryContext(ctx, query, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get user chats: %w", err)
	}
	defer rows.Close()

	var chats []*models.ChatListItem
	for rows.Next() {
		var chatID string
		var messageID, senderID, messageText, messageType sql.NullString
		var isEdited, isDeleted sql.NullBool
		var messageCreatedAt, messageUpdatedAt sql.NullTime
		var unreadCount int
		
		var otherUserID, otherUserName, otherUserSurname, otherUserNickname sql.NullString
		var otherUserAvatarURL sql.NullString
		var otherUserIsOnline sql.NullBool
		
		var groupTitle, groupAvatarURL sql.NullString

		err := rows.Scan(
			&chatID,
			&messageID,
			&senderID,
			&messageText,
			&messageType,
			&isEdited,
			&isDeleted,
			&messageCreatedAt,
			&messageUpdatedAt,
			&unreadCount,
			&otherUserID,
			&otherUserName,
			&otherUserSurname,
			&otherUserNickname,
			&otherUserAvatarURL,
			&otherUserIsOnline,
			&groupTitle,
			&groupAvatarURL,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan chat: %w", err)
		}

		chat := &models.ChatListItem{
			ID:          chatID,
			UnreadCount: unreadCount,
		}

		if len(chatID) > 8 && chatID[:8] == "private_" {
			chat.ChatType = models.ChatTypePrivate
			
			if otherUserID.Valid {
				chat.OtherUser = &models.User{
					ID:       otherUserID.String,
					Name:     otherUserName.String,
					Surname:  otherUserSurname.String,
					Nickname: otherUserNickname.String,
					IsOnline: otherUserIsOnline.Bool,
				}
				if otherUserAvatarURL.Valid {
					chat.OtherUser.AvatarURL = &otherUserAvatarURL.String
				}
				chat.Title = otherUserName.String + " " + otherUserSurname.String
				if otherUserAvatarURL.Valid {
					chat.AvatarURL = otherUserAvatarURL.String
				}
			}
		} else {
			chat.ChatType = models.ChatTypeGroup
			
			if groupTitle.Valid {
				chat.Title = groupTitle.String
			}
			if groupAvatarURL.Valid {
				chat.AvatarURL = groupAvatarURL.String
			}
		}

		if messageID.Valid {
			chat.LastMessage = &models.Message{
				ID:          messageID.String,
				ChatID:      chatID,
				SenderID:    senderID.String,
				MessageText: messageText.String,
				MessageType: models.MessageType(messageType.String),
				IsEdited:    isEdited.Bool,
				IsDeleted:   isDeleted.Bool,
				CreatedAt:   messageCreatedAt.Time,
				UpdatedAt:   messageUpdatedAt.Time,
			}
		}

		if messageUpdatedAt.Valid {
			chat.UpdatedAt = messageUpdatedAt.Time
		} else if messageCreatedAt.Valid {
			chat.UpdatedAt = messageCreatedAt.Time
		} else {
			chat.UpdatedAt = time.Now()
		}

		chats = append(chats, chat)
	}

	return chats, nil
}

func (r *ChatRepository) GetUserChatByID(ctx context.Context, chatID, userID string) (*models.ChatListItem, error) {
	query := `
        WITH LastMessage AS (
            SELECT m.id, m.chat_id, m.sender_id, m.message_text, m.message_type,
                m.is_edited, m.is_deleted, m.created_at, m.updated_at
            FROM messages m
            WHERE m.chat_id = $1 AND NOT m.is_deleted
            ORDER BY m.seq DESC
            LIMIT 1
        ),
        Member AS (
            SELECT last_read_seq
            FROM chat_members
            WHERE chat_id = $1 AND user_id = $2::uuid
        ),
        UnreadCount AS (
            SELECT COUNT(*) AS unread_count
            FROM messages m
            WHERE m.chat_id = $1
              AND m.sender_id != $2::uuid
              AND NOT m.is_deleted
              AND m.seq > COALESCE((SELECT last_read_seq FROM Member), 0)
        ),
        PrivateChatUser AS (
            SELECT u.id, u.name, u.surname, u.nickname, u.avatar_url, u.is_online
            FROM users u
            WHERE u.id = (
                CASE
                    WHEN split_part(regexp_replace($1, '^private_', ''), '_', 1)::uuid = $2::uuid
                        THEN split_part(regexp_replace($1, '^private_', ''), '_', 2)::uuid
                    ELSE split_part(regexp_replace($1, '^private_', ''), '_', 1)::uuid
                END
            )
              AND $1 LIKE 'private_%'
        ),
        GroupChatInfo AS (
            SELECT c.id::text AS chat_id,
                   COALESCE(c.title, 'Group Chat') AS title,
                   c.avatar_url
            FROM chats c
            WHERE c.id::text = $1
        )
        SELECT
            $1 AS id,
            lm.id,
            lm.sender_id,
            lm.message_text,
            lm.message_type,
            lm.is_edited,
            lm.is_deleted,
            lm.created_at,
            lm.updated_at,
            COALESCE((SELECT unread_count FROM UnreadCount), 0),
            pcu.id, pcu.name, pcu.surname, pcu.nickname, pcu.avatar_url, pcu.is_online,
            gci.title, gci.avatar_url
        FROM (SELECT 1) AS anchor
        LEFT JOIN LastMessage lm ON true
        LEFT JOIN PrivateChatUser pcu ON true
        LEFT JOIN GroupChatInfo gci ON true;
    `

	var chatIDResult string
	var messageID, senderID, messageText, messageType sql.NullString
	var isEdited, isDeleted sql.NullBool
	var messageCreatedAt, messageUpdatedAt sql.NullTime
	var unreadCount int

	var otherUserID, otherUserName, otherUserSurname, otherUserNickname sql.NullString
	var otherUserAvatarURL sql.NullString
	var otherUserIsOnline sql.NullBool

	var groupTitle, groupAvatarURL sql.NullString

	err := r.DB.QueryRowContext(ctx, query, chatID, userID).Scan(
		&chatIDResult,
		&messageID,
		&senderID,
		&messageText,
		&messageType,
		&isEdited,
		&isDeleted,
		&messageCreatedAt,
		&messageUpdatedAt,
		&unreadCount,
		&otherUserID,
		&otherUserName,
		&otherUserSurname,
		&otherUserNickname,
		&otherUserAvatarURL,
		&otherUserIsOnline,
		&groupTitle,
		&groupAvatarURL,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to get chat by ID: %w", err)
	}

	chat := &models.ChatListItem{
		ID:          chatIDResult,
		UnreadCount: unreadCount,
	}

	if len(chatIDResult) > 8 && chatIDResult[:8] == "private_" {
		chat.ChatType = models.ChatTypePrivate

		if otherUserID.Valid {
			chat.OtherUser = &models.User{
				ID:       otherUserID.String,
				Name:     otherUserName.String,
				Surname:  otherUserSurname.String,
				Nickname: otherUserNickname.String,
				IsOnline: otherUserIsOnline.Bool,
			}
			if otherUserAvatarURL.Valid {
				chat.OtherUser.AvatarURL = &otherUserAvatarURL.String
			}
			chat.Title = otherUserName.String + " " + otherUserSurname.String
			if otherUserAvatarURL.Valid {
				chat.AvatarURL = otherUserAvatarURL.String
			}
		}
	} else {
		chat.ChatType = models.ChatTypeGroup

		if groupTitle.Valid {
			chat.Title = groupTitle.String
		}
		if groupAvatarURL.Valid {
			chat.AvatarURL = groupAvatarURL.String
		}
	}

	if messageID.Valid {
		chat.LastMessage = &models.Message{
			ID:          messageID.String,
			ChatID:      chatIDResult,
			SenderID:    senderID.String,
			MessageText: messageText.String,
			MessageType: models.MessageType(messageType.String),
			IsEdited:    isEdited.Bool,
			IsDeleted:   isDeleted.Bool,
			CreatedAt:   messageCreatedAt.Time,
			UpdatedAt:   messageUpdatedAt.Time,
		}
	}

	if messageUpdatedAt.Valid {
		chat.UpdatedAt = messageUpdatedAt.Time
	} else if messageCreatedAt.Valid {
		chat.UpdatedAt = messageCreatedAt.Time
	} else {
		chat.UpdatedAt = time.Now()
	}

	return chat, nil
}

func (r *ChatRepository) GetGroupChatBase(ctx context.Context, chatID string,) (*models.ChatListItem, error) {
    query := `
        WITH LastMessage AS (
            SELECT m.id, m.chat_id, m.sender_id, m.message_text, m.message_type,
                m.is_edited, m.is_deleted, m.created_at, m.updated_at
            FROM messages m
            WHERE m.chat_id = $1 AND NOT m.is_deleted
            ORDER BY m.seq DESC
            LIMIT 1
        ),
        GroupChatInfo AS (
            SELECT c.id::text AS chat_id,
				COALESCE(c.title, 'Group Chat') AS title,
				c.avatar_url
            FROM chats c
            WHERE c.id::text = $1
        )
        SELECT
            $1 AS id,
            lm.id,
            lm.sender_id,
            lm.message_text,
            lm.message_type,
            lm.is_edited,
            lm.is_deleted,
            lm.created_at,
            lm.updated_at,
            gci.title,
            gci.avatar_url
        FROM (SELECT 1) AS anchor
        LEFT JOIN LastMessage lm ON true
        LEFT JOIN GroupChatInfo gci ON true;
    `

    var (
        chatIDResult                       string
        messageID, senderID, messageText, messageType sql.NullString
        isEdited, isDeleted                sql.NullBool
        messageCreatedAt, messageUpdatedAt sql.NullTime
        groupTitle, groupAvatarURL         sql.NullString
    )

    err := r.DB.QueryRowContext(ctx, query, chatID).Scan(
        &chatIDResult,
        &messageID,
        &senderID,
        &messageText,
        &messageType,
        &isEdited,
        &isDeleted,
        &messageCreatedAt,
        &messageUpdatedAt,
        &groupTitle,
        &groupAvatarURL,
    )
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, nil
        }
        return nil, fmt.Errorf("failed to get group chat base: %w", err)
    }

    chat := &models.ChatListItem{
        ID:       chatIDResult,
        ChatType: models.ChatTypeGroup,
    }

    if groupTitle.Valid {
        chat.Title = groupTitle.String
    }
    if groupAvatarURL.Valid {
        chat.AvatarURL = groupAvatarURL.String
    }

    if messageID.Valid {
        chat.LastMessage = &models.Message{
            ID:          messageID.String,
            ChatID:      chatIDResult,
            SenderID:    senderID.String,
            MessageText: messageText.String,
            MessageType: models.MessageType(messageType.String),
            IsEdited:    isEdited.Bool,
            IsDeleted:   isDeleted.Bool,
            CreatedAt:   messageCreatedAt.Time,
            UpdatedAt:   messageUpdatedAt.Time,
        }
    }

    switch {
    case messageUpdatedAt.Valid:
        chat.UpdatedAt = messageUpdatedAt.Time
    case messageCreatedAt.Valid:
        chat.UpdatedAt = messageCreatedAt.Time
    default:
        chat.UpdatedAt = time.Now()
    }

    return chat, nil
}

func (r *ChatRepository) SearchChatByNickname(ctx context.Context, query string, currentUserID string, limit, offset int) ([]*models.ChatListItem, error) {
	searchPattern := "%" + query + "%"
	
	sqlQuery := `
		WITH SearchResults AS (
			SELECT
				u.id::text as entity_id,
				CONCAT(u.name, ' ', u.surname) as title,
				u.avatar_url,
				u.nickname,
				u.is_online,
				u.name,
				u.surname,
				u.bio,
				CASE
					WHEN LOWER(u.nickname) = LOWER($2) THEN 0
					WHEN LOWER(u.nickname) LIKE LOWER($3) THEN 1
					WHEN LOWER(u.name) LIKE LOWER($2) OR LOWER(u.surname) LIKE LOWER($2) THEN 2
					ELSE 3
				END as relevance,
				CASE
					WHEN $4::uuid < u.id THEN 'private_' || $4 || '_' || u.id
					ELSE 'private_' || u.id || '_' || $4
				END as chat_id,
				lm.id as last_message_id,
				lm.sender_id as last_message_sender_id,
				lm.message_text as last_message_text,
				lm.message_type as last_message_type,
				lm.is_edited as last_message_is_edited,
				lm.is_deleted as last_message_is_deleted,
				lm.created_at as last_message_created_at,
				lm.updated_at as last_message_updated_at,
				COALESCE(uc.unread_count, 0) as unread_count
			FROM users u
			LEFT JOIN LATERAL (
				SELECT m.id, m.sender_id, m.message_text, m.message_type,
					m.is_edited, m.is_deleted, m.created_at, m.updated_at
				FROM messages m
				WHERE m.chat_id = CASE
					WHEN $4::uuid < u.id THEN 'private_' || $4 || '_' || u.id
					ELSE 'private_' || u.id || '_' || $4
				END
				AND NOT m.is_deleted
				ORDER BY m.seq DESC
				LIMIT 1
			) lm ON true
			LEFT JOIN LATERAL (
				SELECT COUNT(*) as unread_count
				FROM messages m
				LEFT JOIN chat_members cm
					ON cm.chat_id = m.chat_id AND cm.user_id = $4::uuid
				WHERE m.chat_id = CASE
					WHEN $4::uuid < u.id THEN 'private_' || $4 || '_' || u.id
					ELSE 'private_' || u.id || '_' || $4
				END
				AND m.sender_id != $4::uuid
				AND NOT m.is_deleted
				AND m.seq > COALESCE(cm.last_read_seq, 0)
			) uc ON true
			WHERE
				(LOWER(u.nickname) LIKE LOWER($1)
				OR LOWER(u.name) LIKE LOWER($1)
				OR LOWER(u.surname) LIKE LOWER($1))
				AND u.id != $4::uuid
				AND u.approved = TRUE
			UNION ALL
			SELECT
				c.id::text as entity_id,
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
				END as relevance,
				c.id::text as chat_id,
				lm.id as last_message_id,
				lm.sender_id as last_message_sender_id,
				lm.message_text as last_message_text,
				lm.message_type as last_message_type,
				lm.is_edited as last_message_is_edited,
				lm.is_deleted as last_message_is_deleted,
				lm.created_at as last_message_created_at,
				lm.updated_at as last_message_updated_at,
				COALESCE(uc.unread_count, 0) as unread_count
			FROM chats c
			LEFT JOIN LATERAL (
				SELECT m.id, m.sender_id, m.message_text, m.message_type,
					m.is_edited, m.is_deleted, m.created_at, m.updated_at
				FROM messages m
				WHERE m.chat_id = c.id::text AND NOT m.is_deleted
				ORDER BY m.seq DESC
				LIMIT 1
			) lm ON true
			LEFT JOIN LATERAL (
				SELECT COUNT(*) as unread_count
				FROM messages m
				LEFT JOIN chat_members cm
					ON cm.chat_id = m.chat_id AND cm.user_id = $4::uuid
				WHERE m.chat_id = c.id::text
				AND m.sender_id != $4::uuid
				AND NOT m.is_deleted
				AND m.seq > COALESCE(cm.last_read_seq, 0)
			) uc ON true
			WHERE
				(
					LOWER(COALESCE(c.title, '')) LIKE LOWER($1)
					OR LOWER(COALESCE(c.description, '')) LIKE LOWER($1)
				)
		)
		SELECT *
		FROM SearchResults
		ORDER BY relevance ASC, title ASC
		LIMIT $5 OFFSET $6;
	`
	
	rows, err := r.DB.QueryContext(ctx, sqlQuery, 
		searchPattern, query, query+"%", currentUserID, limit, offset)
	if err != nil {
		return nil, fmt.Errorf("failed to search chats: %w", err)
	}
	defer rows.Close()

	var chats []*models.ChatListItem
	for rows.Next() {
		var entityID, title, chatID string
		var avatarURL, nickname, name, surname, bio sql.NullString
		var isOnline sql.NullBool
		var relevance int
		
		var lastMessageID, lastMessageSenderID, lastMessageText, lastMessageType sql.NullString
		var lastMessageIsEdited, lastMessageIsDeleted sql.NullBool
		var lastMessageCreatedAt, lastMessageUpdatedAt sql.NullTime
		
		var unreadCount int

		err := rows.Scan(
			&entityID,
			&title,
			&avatarURL,
			&nickname,
			&isOnline,
			&name,
			&surname,
			&bio,
			&relevance,
			&chatID,
			&lastMessageID,
			&lastMessageSenderID,
			&lastMessageText,
			&lastMessageType,
			&lastMessageIsEdited,
			&lastMessageIsDeleted,
			&lastMessageCreatedAt,
			&lastMessageUpdatedAt,
			&unreadCount,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan search result: %w", err)
		}

		chat := &models.ChatListItem{
			ID:          chatID,
			UnreadCount: unreadCount,
		}

		if len(chatID) > 8 && chatID[:8] == "private_" {
			chat.ChatType = models.ChatTypePrivate
			chat.Title = title
			
			chat.OtherUser = &models.User{
				ID:       entityID,
				Name:     name.String,
				Surname:  surname.String,
				Nickname: nickname.String,
				IsOnline: isOnline.Bool,
			}
			if avatarURL.Valid {
				chat.AvatarURL = avatarURL.String
				chat.OtherUser.AvatarURL = &avatarURL.String
			}
		} else {
			chat.ChatType = models.ChatTypeGroup
			chat.Title = title
			if avatarURL.Valid {
				chat.AvatarURL = avatarURL.String
			}
		}

		if lastMessageID.Valid {
			chat.LastMessage = &models.Message{
				ID:          lastMessageID.String,
				ChatID:      chatID,
				SenderID:    lastMessageSenderID.String,
				MessageText: lastMessageText.String,
				MessageType: models.MessageType(lastMessageType.String),
				IsEdited:    lastMessageIsEdited.Bool,
				IsDeleted:   lastMessageIsDeleted.Bool,
				CreatedAt:   lastMessageCreatedAt.Time,
				UpdatedAt:   lastMessageUpdatedAt.Time,
			}
			chat.UpdatedAt = lastMessageCreatedAt.Time
		}

		chats = append(chats, chat)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating search results: %w", err)
	}

	return chats, nil
}

func (r *ChatRepository) CreateGroupChat(ctx context.Context, chatID, title, description, avatarURL, creatorID string) (*models.ChatListItem, error) {
	query := `
		INSERT INTO chats (id, title, description, avatar_url, created_by)
		VALUES ($1, NULLIF($2, ''), NULLIF($3, ''), NULLIF($4, ''), $5::uuid)
		RETURNING id, title, description, avatar_url, created_by, is_deleted, created_at, updated_at
	`

	var chat models.ChatListItem
	var titleNull, descriptionNull, avatarURLNull, creatorIDNull sql.NullString

	err := r.DB.QueryRowContext(ctx, query,
		chatID,
		title,
		description,
		avatarURL,
		creatorID,
	).Scan(
		&chat.ID,
		&titleNull,
		&descriptionNull,
		&avatarURLNull,
		&creatorIDNull,
		&chat.IsDeleted,
		&chat.CreatedAt,
		&chat.UpdatedAt,
	)

	if err != nil {
		return nil, fmt.Errorf("failed to create group chat: %w", err)
	}

	if titleNull.Valid {
		chat.Title = titleNull.String
	}
	if descriptionNull.Valid {
		chat.Description = descriptionNull.String
	}
	if avatarURLNull.Valid {
		chat.AvatarURL = avatarURLNull.String
	}
	if creatorIDNull.Valid {
		chat.CreatedBy = creatorIDNull.String
	}

	return &chat, nil
}

func (r *ChatRepository) AddChatMembers(ctx context.Context, chatID string, userIDs []string, role string,) error {
    if len(userIDs) == 0 {
        return nil
    }
    query := `
        INSERT INTO chat_members (chat_id, user_id, role, last_read_seq)
        SELECT $1::varchar, unnest($2::uuid[]), $3,
			COALESCE(
				(SELECT MAX(seq) FROM messages WHERE chat_id = $1 AND NOT is_deleted),
				0
			)
        ON CONFLICT (chat_id, user_id) DO NOTHING;
    `
    if _, err := r.DB.ExecContext(ctx, query, chatID, pq.Array(userIDs), role); err != nil {
        return fmt.Errorf("add chat members: %w", err)
    }
    return nil
}

func (r *ChatRepository) AddChatMember(ctx context.Context, chatID, userID, role string) error {
    return r.AddChatMembers(ctx, chatID, []string{userID}, role)
}

func (r *ChatRepository) IsGroupMember(ctx context.Context, chatID, userID string) (bool, error) {
	var exists bool
	query := `
		SELECT EXISTS(
			SELECT 1 
			FROM chat_members 
			WHERE chat_id = $1 AND user_id = $2
		)
	`

	err := r.DB.QueryRowContext(ctx, query, chatID, userID).Scan(&exists)
	if err != nil {
		return false, fmt.Errorf("failed to check group membership: %w", err)
	}

	return exists, nil
}

func (r *ChatRepository) EnsureChatMembers(ctx context.Context, chatID string, userIDs []string,) error {
    if len(userIDs) == 0 {
        return nil
    }
    query := `
        INSERT INTO chat_members (chat_id, user_id, role, last_read_seq)
        SELECT $1::varchar, unnest($2::uuid[]), 'member',
			COALESCE(
				(SELECT MAX(seq) FROM messages WHERE chat_id = $1 AND NOT is_deleted),
				0
			)
        ON CONFLICT (chat_id, user_id) DO NOTHING;
    `
    if _, err := r.DB.ExecContext(ctx, query, chatID, pq.Array(userIDs)); err != nil {
        return fmt.Errorf("ensure chat members: %w", err)
    }
    return nil
}
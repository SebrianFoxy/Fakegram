package services

import (
	"context"
	"fakegram-api/internal/models"
	"time"
)

type ChatNotifier interface {
	NotifyChatListUpdate(chatID string, chat interface{}, excludeUserID string)
	NotifyChatDeleted(chatID string, userID string)
	SubscribeToChat(userID, chatID string)
}

type MessageNotifier interface {
	NotifyNewMessage(receiverID string, message *models.MessageDetail, chatID, senderID string)
	NotifyMessageSent(senderID string, message *models.MessageDetail, chatID, receiverID string)
	NotifyMessageRead(otherUserID, userID, chatID, lastReadMessageID string)
	NotifyMessageReadAll(otherUserID, userID, chatID string)
	NotifyMessageDeleted(chatID, messageID, userID string)
	NotifyMessageEdited(chatID string, message *models.MessageDetail, editorID string)
	NotifyUnreadCountUpdate(userID, chatID string, unreadCount int)
}

type MessageRepository interface {
	CreatePrivateMessage(ctx context.Context, senderID, receiverID string, req *models.CreateMessageRequest) (*models.MessageDetail, error)
	GetMessageDetailByID(ctx context.Context, messageID, userID string) (*models.MessageDetail, error)
	GetMessagesByChat(ctx context.Context, userID, otherUserID string, cursor *time.Time, limit int, direction string) ([]*models.MessageDetail, bool, bool, int64, error)
	DeleteMessage(ctx context.Context, userID, chatID, messageID string) error
	EditMessage(ctx context.Context, messageID, messageText string) (*models.Message, error)
	MarkMessagesAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error
	MarkAllMessagesAsReadInChat(ctx context.Context, userID, chatID string) error
	GetUnreadCount(ctx context.Context, chatID, userID string) (int, error)
}

type ChatRepository interface {
	IsUserInDialog(ctx context.Context, chatID, userID string) (bool, error)
	GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error)
	SearchChatByNickname(ctx context.Context, query string, currentUserID string, limit, offset int) ([]*models.ChatListItem, error)
}

type UserRepository interface {
	CreateUser(ctx context.Context, user *models.User) error
	GetByEmail(ctx context.Context, email string) (*models.User, error)
	GetUserByID(ctx context.Context, id string) (*models.User, error)
	GetByNickname(ctx context.Context, nickname string) (*models.User, error)
	MarkEmailAsVerified(ctx context.Context, userID string) error
	GetAllUsers(ctx context.Context, page, limit int) ([]*models.User, int, error)
}

type TokenRepository interface {
	CreateToken(ctx context.Context, token *models.LoginToken) error
	GetByRefreshToken(ctx context.Context, refreshToken string) (*models.LoginToken, error)
	UpdateToken(ctx context.Context, token *models.LoginToken) error
}

type EncryptionKeyRepository interface {
	CreateEncryptionKey(req *models.CreateUserMasterKeyRequest) error
	GetByUserID(userID string) (*models.UserMasterKey, error)
	UpdateEncryptionKey(userID string, encryptedKey string) error
	DeleteEncryptionKey(userID string) error
}

type UserDeviceRepository interface {
	CreateUserDevice(req *models.CreateDeviceRequest) error
	GetByUserID(userID string) ([]models.UserDevice, error)
	GetByDeviceToken(token string) (*models.UserDevice, error)
	UpdateActivity(deviceToken string) error
	DeleteUserDevice(userID string, deviceID string) error
	DeleteAllUserDevices(userID string) error
}

type KeyCacheService interface {
	SetMasterKey(userID string, key []byte) error
	GetMasterKey(userID string) ([]byte, error)
	DeleteMasterKey(userID string) error
}
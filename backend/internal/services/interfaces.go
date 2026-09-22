package services

import (
	"context"
	"fakegram-api/internal/models"
	"time"
)

type ChatNotifier interface {
	NotifyChatListUpdate(chatID string, chat *models.ChatListItem, excludeUserID string)
	NotifyChatDeleted(chatID string, userID string)
	SubscribeToChat(userID, chatID string)
}

type MessageNotifier interface {
	NotifyNewMessage(receiverID string, message *models.MessageDetail, chatID, senderID string)
	NotifyMessageSent(senderID string, message *models.MessageDetail, chatID, receiverID string)
	NotifyMessageRead(userID, chatID, lastReadMessageID string)
	NotifyMessageReadAll(userID, chatID string)
	NotifyMessageDeleted(chatID, messageID, userID string)
	NotifyMessageEdited(chatID string, message *models.MessageDetail, editorID string)
	NotifyUnreadCountUpdate(userID, chatID string, unreadCount int)
}

type MessageRepository interface {
	CreateMessage(ctx context.Context, chatID, senderID string, req *models.CreateMessageRequest) (string, error)
	GetMessageDetailByID(ctx context.Context, messageID, userID string) (*models.MessageDetail, error)
	DeleteMessage(ctx context.Context, userID, chatID, messageID string) error
	EditMessage(ctx context.Context, messageID, messageText string) (*models.Message, error)
	MarkMessageAsRead(ctx context.Context, messageID, userID string, readAt time.Time) error
	GetUnreadCount(ctx context.Context, chatID, userID string) (int, error)
	GetLastReadTime(ctx context.Context, chatID, userID string) (*time.Time, error)
	GetFirstUnreadTime(ctx context.Context, chatID, userID string, afterTime time.Time) (*time.Time, error)
	GetLastUserMessageTime(ctx context.Context, chatID, userID string) (*time.Time, error)
	GetLastMessageTime(ctx context.Context, chatID string) (*time.Time, error)
	GetMessagesByTimeRange(ctx context.Context, chatID, userID string, anchorTime time.Time, limit int, direction string) ([]*models.MessageDetail, error)
	HasOlderMessages(ctx context.Context, chatID string, beforeTime time.Time) (bool, error)
	HasNewerMessages(ctx context.Context, chatID string, beforeTime time.Time) (bool, error)
	GetLastMessageFromOthersUser(ctx context.Context, chatID, excludeUserID string) (*models.Message, error)
	GetMessageTime(ctx context.Context, messageID, chatID string) (time.Time, error)
	GetUnreadCountsForChat(ctx context.Context, chatID string) (map[string]int, error)
}

type ChatRepository interface {
	GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error)
	GetUserChatByID(ctx context.Context, chatID, userID string) (*models.ChatListItem, error)
	SearchChatByNickname(ctx context.Context, query string, currentUserID string, limit, offset int) ([]*models.ChatListItem, error)
	IsGroupMember(ctx context.Context, chatID, userID string) (bool, error)
	CreateGroupChat(ctx context.Context, chatID, title, description, avatarURL, creatorID string) (*models.ChatListItem, error)
	AddChatMember(ctx context.Context, chatID, userID, role string) error
	AddChatMembers(ctx context.Context, chatID string, userIDs []string, role string) error
	GetGroupChatBase(ctx context.Context, chatID string,) (*models.ChatListItem, error)
	EnsureChatMembers(ctx context.Context, chatID string, userIDs []string,) error
}

type UserRepository interface {
	CreateUser(ctx context.Context, user *models.User) error
	GetByEmail(ctx context.Context, email string) (*models.User, error)
	GetUserByID(ctx context.Context, id string) (*models.User, error)
	GetByNickname(ctx context.Context, nickname string) (*models.User, error)
	MarkEmailAsVerified(ctx context.Context, userID string) error
	GetAllUsers(ctx context.Context, page, limit int) ([]*models.User, int, error)
	UpdatePassword(ctx context.Context, userID, newPasswordHash string) error
	CheckUsersApproved(ctx context.Context, userIDs ...string) (bool, error)
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

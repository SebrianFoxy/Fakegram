package handlers

import (
	"context"
	"fakegram-api/internal/models"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type MessageService interface {
	SendMessage(ctx context.Context, senderID string, req *models.CreateMessageRequest) (*models.MessageDetail, error)
	GetMessagesByChat(ctx context.Context, userID, otherUserID string, cursor *time.Time, limit int, direction string) (*models.GetMessagesResponse, error)
	DeleteMessage(ctx context.Context, userID, messageID string) error
	EditMessage(ctx context.Context, userID, messageID string, req *models.UpdateMessageRequest) (*models.MessageDetail, error)
	MarkAsRead(ctx context.Context, userID, chatID, lastReadMessageID string) error
	MarkAllAsRead(ctx context.Context, userID, chatID string) error
}

type ChatService interface {
	GetUserChats(ctx context.Context, userID string) ([]*models.ChatListItem, error)
	SearchChatByNickname(ctx context.Context, currentUserID, query string, limit, offset int) ([]*models.ChatListItem, error)
}

type TokenService interface {
	GenerateTokens(userID string) (*models.LoginToken, error)
	RefreshTokens(existingToken *models.LoginToken, refreshRotate bool) (*models.LoginToken, error)
	ValidateAccessToken(tokenString string) (*jwt.RegisteredClaims, error)
	GetTokenResponse(loginToken *models.LoginToken) *models.TokenResponse
	CreateToken(ctx context.Context, token *models.LoginToken) error
	UpdateToken(ctx context.Context, token *models.LoginToken) error
	GetByRefreshToken(ctx context.Context, refreshToken string) (*models.LoginToken, error)
}

type EmailVerificationService interface {
	SendVerificationEmail(toEmail, userID string) error
	VerifyToken(token string) (*models.EmailVerificationToken, error)
	RenderVerificationSuccess() (string, error)
	RenderVerificationError() (string, error)
}

type UserService interface {
	GetByNickname(ctx context.Context, userID string) (*models.User, error)
	GetByEmail(ctx context.Context, userEmail string) (*models.User, error)
	GetUserByID(ctx context.Context, id string) (*models.User, error)
	CreateUser(ctx context.Context, req *models.RegistrationRequest) (*models.User, error)
	AuthenticateUser(ctx context.Context, email, password string) (*models.User, error)
	MarkEmailAsVerified(ctx context.Context, userID string) error
	GetAllUsers(ctx context.Context, page, limit int) (*models.GetAllUsersResponse, error)
}

type CryptoService interface {
	InitUserKeys(ctx context.Context, userID, password string) error
	GetOrCreateUserKey(ctx context.Context, userID, password string) (*models.UserMasterKey, error)
	GenerateUserKeys(password string) (encryptedPrivateKey, salt, publicKey string, err error)
	DeriveAndCacheKey(userID, password string, masterKey *models.UserMasterKey) ([]byte, error)
	EncryptMessage(userMessage string) (string, error)
	DecryptMessage(encryptedText string) ([]byte, error)
	RegisterDevice(ctx context.Context, userID, deviceID, deviceName string) (string, error)
	DeleteCachedKey(userID string)
	GetCachedKey(userID string) ([]byte, error)
}

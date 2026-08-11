package services

import (
	"context"
	"errors"
	"fmt"
	"regexp"
	"strings"
	"time"
	"unicode/utf8"

	"fakegram-api/internal/models"
)

var (
	ErrInvalidCredentials = errors.New("invalid email or password")
	ErrAccountNotApproved = errors.New("account not approved")
	ErrEmailExists        = errors.New("email already exists")
	ErrNicknameExists     = errors.New("nickname already exists")
	ErrNotFound       	  = errors.New("user not found")
	ErrInvalidToken       = errors.New("invalid refresh token")
	ErrTokenExpired       = errors.New("refresh token expired")
)

type EmailNotConfirmedError struct {
	Email  string
	UserID string
}

func (e *EmailNotConfirmedError) Error() string {
	return fmt.Sprintf("email %s exists but not confirmed", e.Email)
}

type UserService struct {
	userRepo  UserRepository
	passwordService PasswordService
}

func NewUserService(
	userRepo UserRepository,
	passwordService PasswordService,
) *UserService {
	return &UserService {
		userRepo: userRepo,
		passwordService: passwordService,
	}
}

func (s *UserService) GetByNickname(ctx context.Context, userID string) (*models.User, error) {
	if userID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	user, err := s.userRepo.GetByNickname(ctx, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get user: %w", err)
	}

	return user, nil;
}

func (s *UserService) GetByEmail(ctx context.Context, userEmail string) (*models.User, error) {
	if userEmail == "" {
		return nil, fmt.Errorf("user email is required")
	}

	user, err := s.userRepo.GetByEmail(ctx, userEmail)
	if err != nil {
		return nil, fmt.Errorf("failed to get user by email: %w", err)
	}

	return user, nil
}

func (s *UserService) GetUserByID(ctx context.Context, id string) (*models.User, error) {
	if id == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	user, err := s.userRepo.GetUserByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("failed to get user by ID: %w", err)
	}

	return user, nil
}

func (s *UserService) GetAllUsers(ctx context.Context, page, limit int) (*models.GetAllUsersResponse, error) {
	if page < 1 {
		page = 1
	}
	if limit < 1 || limit > 100 {
		limit = 10
	}

	users, totalCount, err := s.userRepo.GetAllUsers(ctx, page, limit)
	if err != nil {
		return nil, fmt.Errorf("failed to get users: %w", err)
	}

	usersResponse := make([]models.UserResponse, len(users))
	for i, user := range users {
		usersResponse[i] = user.ToResponse()
	}

	return &models.GetAllUsersResponse{
		Users:      usersResponse,
		TotalCount: totalCount,
	}, nil
}

func (s *UserService) CreateUser(ctx context.Context, req *models.RegistrationRequest) (*models.User, error) {
	email := normalizeEmail(req.Email)
    nickname := normalizeNickname(req.Nickname)

	if !isEmailValid(email) {
		return nil, fmt.Errorf("invalid email format")
	}

	existingByEmail, _ := s.userRepo.GetByEmail(ctx, email)
	if existingByEmail != nil {
		if !existingByEmail.Approved {
			return nil, &EmailNotConfirmedError{
				Email:  email,
				UserID: existingByEmail.ID,
			}
		}
		return nil, ErrEmailExists
	}

	existingByNickname, _ := s.userRepo.GetByNickname(ctx, nickname)
	if existingByNickname != nil {
		return nil, ErrNicknameExists
	}

	hashedPassword, err := s.passwordService.HashPassword(req.Password)
	if err != nil {
		return nil, fmt.Errorf("failed to hash password: %w", err)
	}

	user := &models.User{
        Name:      strings.TrimSpace(req.Name),
        Surname:   strings.TrimSpace(req.Surname),
        Nickname:  nickname,
        Email:     email,
        Password:  hashedPassword,  
        Approved:  false,
        CreatedAt: time.Now(),
        UpdatedAt: time.Now(),
    }

	if err := s.userRepo.CreateUser(ctx, user); err != nil {
		return nil, err
	}

	return user, nil
}

func (s *UserService) AuthenticateUser(ctx context.Context, email, password string) (*models.User, error) {
	user, err := s.userRepo.GetByEmail(ctx, email)
	if err != nil {
		if errors.Is(err, ErrNotFound) {
			return nil, ErrInvalidCredentials
		}
		return nil, fmt.Errorf("failed to get user: %w", err)
	}

	if !s.passwordService.VerifyPassword(password, user.Password) {
		return nil, ErrInvalidCredentials
	}

	return user, nil
}

func (s *UserService) MarkEmailAsVerified(ctx context.Context, userID string) error {
	if userID == "" {
		return fmt.Errorf("user ID is required")
	}

	return s.userRepo.MarkEmailAsVerified(ctx, userID)
}

func (s *UserService) UpgradePassword(ctx context.Context, userID, password string) error {
	hashedPassword, err := s.passwordService.HashPassword(password)
	if err != nil {
		return fmt.Errorf("failed to hash password: %w", err)
	}

	return s.userRepo.UpdatePassword(ctx, userID, hashedPassword)
}

func (s *UserService) UpdatePassword(ctx context.Context, userID, newPassword string) error {
	hashedPassword, err := s.passwordService.HashPassword(newPassword)
	if err != nil {
		return fmt.Errorf("failed to hash password: %w", err)
	}

	return s.userRepo.UpdatePassword(ctx, userID, hashedPassword)
}

func normalizeEmail(email string) string {
	return strings.ToLower(strings.TrimSpace(email))
}

func isEmailValid(email string) bool {
	if email == "" || utf8.RuneCountInString(email) > 254 {
		return false
	}
	re := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
	return re.MatchString(email)
}

func normalizeNickname(nickname string) string {
	return strings.ToLower(strings.TrimSpace(nickname))
}
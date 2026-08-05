package services

import (
	"context"
	"errors"
	"fmt"

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
}

func NewUserService(
	userRepo UserRepository,
) *UserService {
	return &UserService {
		userRepo: userRepo,
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
	user := models.NewUserFromRequest(req)

	if !user.IsEmailValid() {
		return nil, fmt.Errorf("invalid email format")
	}

	if err := user.HashPassword(); err != nil {
		return nil, fmt.Errorf("failed to process password: %w", err)
	}

	existingUserByNickname, err := s.userRepo.GetByNickname(ctx, user.Nickname)

	if err != nil {
		if !errors.Is(err, ErrNotFound) {
			return nil, fmt.Errorf("failed to check nickname availability: %w", err)
		}
	}
	
	if existingUserByNickname != nil {
		return nil, ErrNicknameExists
	}

	if err := s.userRepo.CreateUser(ctx, user); err != nil {
		if errors.Is(err, ErrEmailExists) {
			existingUser, err := s.userRepo.GetByEmail(ctx, user.Email)

			if err != nil {
				return nil, fmt.Errorf("failed to check user status: %w", err)
			}

			if existingUser != nil && !existingUser.Approved {
				return nil, &EmailNotConfirmedError{
					Email:  user.Email,
					UserID: existingUser.ID,
				}
			}
			return nil, ErrEmailExists
		}
		return nil, fmt.Errorf("failed to create user: %w", err)
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

	if !user.CheckPassword(password) {
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
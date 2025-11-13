package repositories

import (
	"errors"
	"fakegram-api/internal/models"
	"fmt"

	"context"
	"database/sql"

	"github.com/lib/pq"
)

var (
    ErrNotFound      = errors.New("not found")
    ErrEmailExists   = errors.New("email already exists")
    ErrDatabase      = errors.New("database error")
)

type UserRepository struct {
    DB *sql.DB
}

func NewUserRepository(db *sql.DB) *UserRepository {
    return &UserRepository{DB: db}
}


func (h *UserRepository) CreateUser(ctx context.Context, user *models.User) error {
    query := `
        INSERT INTO users (name, surname, nickname, email, password, approved) 
        VALUES ($1, $2, $3, $4, $5, $6) 
        RETURNING id, created_at, updated_at
    `
    err := h.DB.QueryRowContext(
        ctx, query, 
        user.Name, 
        user.Surname,
        user.Nickname,
        user.Email, 
        user.Password,
        user.Approved,
        ).Scan(&user.ID, &user.CreatedAt, &user.UpdatedAt)
    
    if err != nil {
        if pqErr, ok := err.(*pq.Error); ok {
            if pqErr.Code.Name() == "unique_violation" {
                return ErrEmailExists
            }
        }
        return err
    }

    return nil
}

func (r *UserRepository) GetAllUsers(ctx context.Context, page, limit int) ([]*models.User, int, error) {
    var totalCount int
    countQuery := `SELECT COUNT(*) FROM users`
    err := r.DB.QueryRowContext(ctx, countQuery).Scan(&totalCount)
    if err != nil {
        return nil, 0, fmt.Errorf("failed to count users: %w", err)
    }

    offset := (page - 1) * limit

    query := `
        SELECT 
            id, name, surname, nickname, email, approved, bio, 
            avatar_url, is_online, last_seen, created_at, updated_at 
        FROM users 
        ORDER BY created_at DESC 
        LIMIT $1 OFFSET $2
    `
    
    rows, err := r.DB.QueryContext(ctx, query, limit, offset)
    if err != nil {
        return nil, 0, fmt.Errorf("failed to get users: %w", err)
    }
    defer rows.Close()

    var users []*models.User
    for rows.Next() {
        var user models.User
        err := rows.Scan(
            &user.ID,
            &user.Name,
            &user.Surname,
            &user.Nickname,
            &user.Email,
            &user.Approved,
            &user.Bio,
            &user.AvatarURL,
            &user.IsOnline,
            &user.LastSeen,
            &user.CreatedAt,
            &user.UpdatedAt,
        )
        if err != nil {
            return nil, 0, fmt.Errorf("failed to scan user: %w", err)
        }
        users = append(users, &user)
    }

    if err := rows.Err(); err != nil {
        return nil, 0, fmt.Errorf("rows error: %w", err)
    }

    return users, totalCount, nil
}

func (r *UserRepository) GetByEmail(ctx context.Context, email string) (*models.User, error){
    query := `
        SELECT id, name, surname, nickname, email, password, approved, created_at, updated_at
        FROM users
        WHERE email = $1
    `

    var user models.User
    err := r.DB.QueryRowContext(ctx, query, email).Scan(
        &user.ID,
        &user.Name,
        &user.Surname,
        &user.Nickname,
        &user.Email,
        &user.Password,
        &user.Approved,
        &user.CreatedAt,
        &user.UpdatedAt,
    )
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, ErrNotFound
        }
        return nil, fmt.Errorf("failed to get user by email: %w", err)
    }
    return &user, nil
}

func (r *UserRepository) GetUserByID(ctx context.Context, id string) (*models.User, error) {
    var user models.User
    err := r.DB.QueryRowContext(ctx, 
        "SELECT id, name, surname, email, nickname, approved, created_at, updated_at FROM users WHERE id = $1", id).
        Scan(
            &user.ID, 
            &user.Name, 
            &user.Surname,
            &user.Nickname,
            &user.Email, 
            &user.Approved,
            &user.CreatedAt, 
            &user.UpdatedAt,
        )
    
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, ErrNotFound
        }
        return nil, err
    }
    
    return &user, nil
}

func (r *UserRepository) GetByNickname(ctx context.Context, nickname string) (*models.User, error) {
    query := `
        SELECT id, name, surname, nickname, email, password, approved, created_at, updated_at
        FROM users
        WHERE LOWER(nickname) = LOWER($1)
    `

    var user models.User
    err := r.DB.QueryRowContext(ctx, query, nickname).Scan(
        &user.ID,
        &user.Name,
        &user.Surname,
        &user.Nickname,
        &user.Email,
        &user.Password,
        &user.Approved,
        &user.CreatedAt,
        &user.UpdatedAt,
    )
    if err != nil {
        if err == sql.ErrNoRows {
            return nil, ErrNotFound
        }
        return nil, fmt.Errorf("failed to get user by nickname: %w", err)
    }
    return &user, nil
}

func (r *UserRepository) MarkEmailAsVerified(ctx context.Context, userID string) error {
    query := `UPDATE users SET approved = true, updated_at = NOW() WHERE id = $1`
    
    result, err := r.DB.ExecContext(ctx, query, userID)
    if err != nil {
        return fmt.Errorf("failed to mark email as verified: %w", err)
    }
    
    rowsAffected, err := result.RowsAffected()
    if err != nil {
        return fmt.Errorf("failed to get rows affected: %w", err)
    }
    
    if rowsAffected == 0 {
        return fmt.Errorf("user not found with id: %s", userID)
    }
    
    return nil
}
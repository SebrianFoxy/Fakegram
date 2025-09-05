package models

import (
	"time"
    "golang.org/x/crypto/bcrypt"
)

type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name" validate:"required"`
    Email     string    `json:"email" validate:"required,email"`
    Password  string    `json:"password,omitempty" validate:"required"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type CreateUserRequest struct {
    Name     string `json:"name" validate:"required"`
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required,min=6"`
}

type UserResponse struct {
    ID        string       `json:"id"`
    Name      string    `json:"name"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

func (u *User) ToResponse() UserResponse {
    return UserResponse{
        ID:        u.ID,
        Name:      u.Name,
        Email:     u.Email,
        CreatedAt: u.CreatedAt,
        UpdatedAt: u.UpdatedAt,
    }
}


type UserService interface {
    CreateUser(user *User) error
    GetUser(id string) (*User, error)
    GetAllUsers() ([]*User, error)
    UpdateUser(id string, user *User) error
    DeleteUser(id string) error
}

func (u *User) HashPassword() error {
    hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
    if err != nil {
        return err
    }
    u.Password = string(hashedPassword)
    return nil
}

func (u *User) CheckPassword(password string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
    return err == nil
}
package models

import (
	"time"
)

type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name" validate:"required"`
    Surname   string    `json:"surname" validate:"required"`
    Email     string    `json:"email" validate:"required,email"`
    Password  string    `json:"password,omitempty" validate:"required"`
    Approved  bool      `json:"approved"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type UserResponse struct {
    ID        string    `json:"id"`
    Name      string    `json:"name"`
    Surname   string    `json:"surname"`
    Email     string    `json:"email"`
    Approved  bool      `json:"approved"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type UserService interface {
    CreateUser(user *User) error
    GetUser(id string) (*User, error)
    GetAllUsers() ([]*User, error)
    UpdateUser(id string, user *User) error
    DeleteUser(id string) error
    // GetUserByID(id string) (*User, error)
}

func (u *User) ToResponse() UserResponse {
    return UserResponse{
        ID:        u.ID,
        Name:      u.Name,
        Surname:   u.Surname,
        Email:     u.Email,
        Approved:  u.Approved,
        CreatedAt: u.CreatedAt,
        UpdatedAt: u.UpdatedAt,
    }
}




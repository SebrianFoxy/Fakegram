package models

import (
	"time"
)

type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name" validate:"required"`
    Email     string    `json:"email" validate:"required,email"`
    Password  string    `json:"password" validate:"required"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type UserService interface {
    CreateUser(user *User) error
    GetUser(id int) (*User, error)
    GetAllUsers() ([]*User, error)
    UpdateUser(id int, user *User) error
    DeleteUser(id int) error
}
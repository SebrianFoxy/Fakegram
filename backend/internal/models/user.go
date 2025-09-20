package models

import (
	"time"
    "golang.org/x/crypto/bcrypt"
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

type CreateUserRequest struct {
    Name     string `json:"name" validate:"required"`
    Surname  string `json:"surname" validate:"required"`
    Email    string `json:"email" validate:"required,email"`
    Password string `json:"password" validate:"required,min=6"`
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


type UserService interface {
    CreateUser(user *User) error
    GetUser(id string) (*User, error)
    GetAllUsers() ([]*User, error)
    UpdateUser(id string, user *User) error
    DeleteUser(id string) error
    // GetUserByID(id string) (*User, error)
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

func NewUserFromRequest(req *CreateUserRequest) *User {
    return &User{
        Name:      req.Name,
        Surname:   req.Surname,
        Email:     req.Email,
        Password:  req.Password,
        Approved:  false,
        CreatedAt: time.Now(),
        UpdatedAt: time.Now(),
    }
}
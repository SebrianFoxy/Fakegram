package models

import (
	"time"
)

type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name" validate:"required"`
    Surname   string    `json:"surname" validate:"required"`
    Nickname  string    `json:"nickname" validate:"required"`
    Email     string    `json:"email" validate:"required,email"`
    Password  string    `json:"password,omitempty" validate:"required"`
    Approved  bool      `json:"approved"`
    Bio       *string   `json:"bio"`
    AvatarURL *string   `json:"avatar_url"`
    IsOnline  bool      `json:"is_online"`
    LastSeen  time.Time `json:"last_seen"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

type GetAllUsersResponse struct {
	Users      []UserResponse
	TotalCount int
}

type UserResponse struct {
    ID        string    `json:"id"`
    Name      string    `json:"name"`
    Surname   string    `json:"surname"`
    Nickname  string    `json:"nickname"`
    Email     string    `json:"email"`
    Approved  bool      `json:"approved"`
    Bio       string    `json:"bio"`
    AvatarURL string    `json:"avatar_url"`
    IsOnline  bool      `json:"is_online"`
    LastSeen  time.Time `json:"last_seen"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

func (u *User) ToResponse() UserResponse {
    var bio string
    if u.Bio != nil {
        bio = *u.Bio
    }

    var avatarURL string
    if u.AvatarURL != nil {
        avatarURL = *u.AvatarURL
    }

    return UserResponse{
        ID:        u.ID,
        Name:      u.Name,
        Surname:   u.Surname,
        Nickname:  u.Nickname,
        Email:     u.Email,
        Approved:  u.Approved,
        Bio:       bio,
        AvatarURL: avatarURL,
        IsOnline:  u.IsOnline,
        LastSeen:  u.LastSeen,
        CreatedAt: u.CreatedAt,
        UpdatedAt: u.UpdatedAt,
    }
}




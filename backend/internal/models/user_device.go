package models

import (
	"time"

)

type UserDevice struct {
	ID          string 	  `json:"id"`
	UserID      string 	  `json:"user_id"`
	DeviceID    string    `json:"device_id"`
	DeviceName  string    `json:"device_name"`
	DeviceToken string    `json:"device_token"`
	LastActive  time.Time `json:"last_active"`
	CreatedAt   time.Time `json:"created_at"`
}

type CreateDeviceRequest struct {
	UserID      string 	  `json:"user_id" validate:"required"`
	DeviceID    string    `json:"device_id" validate:"required"`
	DeviceName  string    `json:"device_name"`
	DeviceToken string    `json:"device_token" validate:"required"`
}

type UpdateDeviceRequest struct {
	DeviceName string `json:"device_name"`
}

type DeviceInfo struct {
	ID         string 	 `json:"id"`
	DeviceID   string    `json:"device_id"`
	DeviceName string    `json:"device_name"`
	LastActive time.Time `json:"last_active"`
	IsCurrent  bool      `json:"is_current"`
}
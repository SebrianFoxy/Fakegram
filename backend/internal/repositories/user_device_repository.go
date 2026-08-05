package repositories

import (
	"database/sql"
	"fmt"

	"fakegram-api/internal/models"

)

type UserDeviceRepository struct {
	db *sql.DB
}

func NewUserDeviceRepository(db *sql.DB) *UserDeviceRepository {
	return &UserDeviceRepository{db: db}
}

func (r *UserDeviceRepository) CreateUserDevice(req *models.CreateDeviceRequest) error {
	query := `
		INSERT INTO users_devices (user_id, device_id, device_name, device_token)
		VALUES ($1, $2, $3, $4)
		ON CONFLICT (user_id, device_id) 
		DO UPDATE SET device_token = $4, device_name = $3, last_active = CURRENT_TIMESTAMP
	`

	_, err := r.db.Exec(query, req.UserID, req.DeviceID, req.DeviceName, req.DeviceToken)
	if err != nil {
		return fmt.Errorf("failed to create device: %w", err)
	}

	return nil
}

func (r *UserDeviceRepository) GetByUserID(userID string) ([]models.UserDevice, error) {
	query := `
		SELECT id, user_id, device_id, device_name, device_token, last_active, created_at
		FROM users_devices
		WHERE user_id = $1
		ORDER BY last_active DESC
	`

	rows, err := r.db.Query(query, userID)
	if err != nil {
		return nil, fmt.Errorf("failed to get user devices: %w", err)
	}
	defer rows.Close()

	var devices []models.UserDevice
	for rows.Next() {
		var d models.UserDevice
		err := rows.Scan(&d.ID, &d.UserID, &d.DeviceID, &d.DeviceName,
			&d.DeviceToken, &d.LastActive, &d.CreatedAt)
		if err != nil {
			continue
		}
		devices = append(devices, d)
	}

	return devices, nil
}

func (r *UserDeviceRepository) GetByDeviceToken(token string) (*models.UserDevice, error) {
	query := `
		SELECT id, user_id, device_id, device_name, device_token, last_active, created_at
		FROM users_devices
		WHERE device_token = $1
	`

	device := &models.UserDevice{}
	err := r.db.QueryRow(query, token).Scan(
		&device.ID, &device.UserID, &device.DeviceID, &device.DeviceName,
		&device.DeviceToken, &device.LastActive, &device.CreatedAt,
	)

	if err == sql.ErrNoRows {
		return nil, fmt.Errorf("device not found")
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get device: %w", err)
	}

	return device, nil
}

func (r *UserDeviceRepository) UpdateActivity(deviceToken string) error {
	query := `UPDATE users_devices SET last_active = CURRENT_TIMESTAMP WHERE device_token = $1`

	_, err := r.db.Exec(query, deviceToken)
	if err != nil {
		return fmt.Errorf("failed to update device activity: %w", err)
	}

	return nil
}

func (r *UserDeviceRepository) DeleteUserDevice(userID string, deviceID string) error {
	query := `DELETE FROM users_devices WHERE user_id = $1 AND device_id = $2`

	_, err := r.db.Exec(query, userID, deviceID)
	if err != nil {
		return fmt.Errorf("failed to delete device: %w", err)
	}

	return nil
}

func (r *UserDeviceRepository) DeleteAllUserDevices(userID string) error {
	query := `DELETE FROM users_devices WHERE user_id = $1`

	_, err := r.db.Exec(query, userID)
	if err != nil {
		return fmt.Errorf("failed to delete all user devices: %w", err)
	}

	return nil
}
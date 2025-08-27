package database

import (
	"database/sql"
	"fakegram-api/internal/config"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func InitDB(cfg *config.Config) (*sql.DB, error) {
    adminConn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=postgres sslmode=disable",
        cfg.DBHost, cfg.DBPort, cfg.DBUser, cfg.DBPassword)
    dbAdmin, err := sql.Open("postgres", adminConn)
    if err != nil {
        return nil, err
    }
    defer dbAdmin.Close()

    var exists int
    err = dbAdmin.QueryRow("SELECT 1 FROM pg_database WHERE datname=$1", cfg.DBName).Scan(&exists)
    if err == sql.ErrNoRows {
        _, err = dbAdmin.Exec("CREATE DATABASE " + cfg.DBName)
        if err != nil {
            return nil, fmt.Errorf("failed to create database: %v", err)
        }
        log.Printf("Database %s created successfully", cfg.DBName)
    } else if err != nil {
        return nil, err
    }

    connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
        cfg.DBHost, cfg.DBPort, cfg.DBUser, cfg.DBPassword, cfg.DBName)
    db, err := sql.Open("postgres", connStr)
    if err != nil {
        return nil, err
    }

    err = db.Ping()
    if err != nil {
        return nil, err
    }

    log.Println("Successfully connected to PostgreSQL!")
    return db, nil
}

func CreateTableUsers(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
		password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
    `

    _, err := db.Exec(query)
    if err != nil {
        return err
    }

    log.Println("Tables created successfully!")
    return nil
}
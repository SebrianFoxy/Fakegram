package database

import (
	"database/sql"
	"fakegram-api/internal/config"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var db *sql.DB

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

func GetDB() *sql.DB{
    return db
}


func CreateTableUsers(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS users (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        name VARCHAR(255) NOT NULL,
        surname VARCHAR(255) NOT NULL,
        nickname VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
		password VARCHAR(255) NOT NULL,
        approved BOOL DEFAULT FALSE,
        bio TEXT,
        avatar_url VARCHAR(500),
        is_online BOOLEAN DEFAULT FALSE,
        last_seen TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    `

    _, err := db.Exec(query)
    if err != nil {
        return err
    }

    log.Println("Users table created successfully!")
    return nil
}

func CreateTableChatMembers(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS chat_members (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        chat_id VARCHAR(255) NOT NULL,
        user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        role VARCHAR(20) DEFAULT 'member',
        joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(chat_id, user_id)
    );


    CREATE INDEX IF NOT EXISTS idx_chat_members_user_id ON chat_members(user_id);
    CREATE INDEX IF NOT EXISTS idx_chat_members_chat_id ON chat_members(chat_id);
    `

    _, err := db.Exec(query)
    if err != nil {
        return err
    }

    log.Println("Chat_members table created successfully!")
    return nil
}

func CreateTableChats(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS chats (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        chat_type VARCHAR(20) DEFAULT 'private',
        title VARCHAR(255),
        description TEXT,
        avatar_url VARCHAR(500),
        created_by UUID REFERENCES users(id),
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    `

    _, err := db.Exec(query)
    if err != nil {
        return err
    }

    log.Println("Chats table created successfully!")
    return nil
}

func CreateTableMessages(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS messages (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        chat_id VARCHAR(255) NOT NULL,
        sender_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        message_text TEXT,
        message_type VARCHAR(20) DEFAULT 'text',
        reply_to_message_id UUID REFERENCES messages(id) ON DELETE SET NULL,
        is_edited BOOLEAN DEFAULT FALSE,
        is_deleted BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE INDEX IF NOT EXISTS idx_messages_chat_id_created_at ON messages(chat_id, created_at);
    CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON messages(sender_id);
    CREATE INDEX IF NOT EXISTS idx_messages_reply_to ON messages(reply_to_message_id);
    `
    
    _, err := db.Exec(query)
    if err != nil {
        return fmt.Errorf("failed to create messages table: %v", err)
    }

    log.Println("Messages table created successfully!")
    return nil
}

func CreateTableMessageReadStatus(db *sql.DB) error {
    query := `
        CREATE TABLE IF NOT EXISTS message_read_status (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
            user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            read_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            UNIQUE(message_id, user_id)
        );

        CREATE INDEX IF NOT EXISTS idx_message_read_status_user ON message_read_status(user_id);
        CREATE INDEX IF NOT EXISTS idx_message_read_status_message ON message_read_status(message_id);
    `
    
    _, err := db.Exec(query)
    if err != nil {
        return fmt.Errorf("failed to create message_read_status table: %v", err)
    }

    log.Println("Message_read_status table created successfully!")
    return nil
}

func CreateTableTokens(db *sql.DB) error {
    query := `
    CREATE TABLE IF NOT EXISTS login_tokens (
        id UUID PRIMARY KEY,
        access_token TEXT NOT NULL,
        refresh_token TEXT NOT NULL,
        user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        created_at TIMESTAMP NOT NULL,
        expired_at TIMESTAMP NOT NULL,
        refresh_token_expired_at TIMESTAMP NOT NULL
    )`

    _, err := db.Exec(query)
    if err != nil {
        return err
    }

    log.Println("Tokens table created successfully!")
    return nil
}
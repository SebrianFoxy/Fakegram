package migrations

import (
    "database/sql"
    "fmt"
    "log"
)

func AddUpdatedAtToMessages(db *sql.DB) error {
    query := `
    ALTER TABLE messages 
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
    `
    
    _, err := db.Exec(query)
    if err != nil {
        return fmt.Errorf("failed to add updated_at column: %v", err)
    }

    updateQuery := `
    UPDATE messages 
    SET updated_at = created_at 
    WHERE updated_at IS NULL;
    `
    
    _, err = db.Exec(updateQuery)
    if err != nil {
        return fmt.Errorf("failed to update existing records: %v", err)
    }

    functionQuery := `
    CREATE OR REPLACE FUNCTION update_messages_updated_at()
    RETURNS TRIGGER AS $$
    BEGIN
        NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    `
    
    _, err = db.Exec(functionQuery)
    if err != nil {
        return fmt.Errorf("failed to create trigger function: %v", err)
    }

    triggerQuery := `
    DROP TRIGGER IF EXISTS trigger_messages_updated_at ON messages;
    
    CREATE TRIGGER trigger_messages_updated_at
        BEFORE UPDATE ON messages
        FOR EACH ROW
        EXECUTE FUNCTION update_messages_updated_at();
    `
    
    _, err = db.Exec(triggerQuery)
    if err != nil {
        return fmt.Errorf("failed to create trigger: %v", err)
    }

    log.Println("Migration 003: Added updated_at to messages table successfully!")
    return nil
}
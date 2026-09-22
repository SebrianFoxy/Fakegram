package migrations

import (
    "database/sql"
    "fmt"
    "log"
)

func AddLastReadSeqToChatMembers(db *sql.DB) error {
    addColumn := `
    ALTER TABLE chat_members
    ADD COLUMN IF NOT EXISTS last_read_seq BIGINT;
    `
    if _, err := db.Exec(addColumn); err != nil {
        return fmt.Errorf("add last_read_seq: %w", err)
    }

    backfill := `
    WITH last_read AS (
        SELECT m.chat_id,
               mrs.user_id,
               MAX(m.seq) AS max_seq
        FROM message_read_status mrs
        JOIN messages m ON m.id = mrs.message_id
        GROUP BY m.chat_id, mrs.user_id
    )
    UPDATE chat_members cm
    SET last_read_seq = lr.max_seq
    FROM last_read lr
    WHERE cm.chat_id = lr.chat_id
      AND cm.user_id = lr.user_id
      AND (cm.last_read_seq IS NULL OR cm.last_read_seq < lr.max_seq);
    `
    if _, err := db.Exec(backfill); err != nil {
        return fmt.Errorf("backfill last_read_seq: %w", err)
    }

    log.Println("Migration 003: Added last_read_seq to chat_members successfully!")
    return nil
}
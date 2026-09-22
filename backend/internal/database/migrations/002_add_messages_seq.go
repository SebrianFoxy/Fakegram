package migrations

import (
    "database/sql"
    "fmt"
    "log"
)

func AddSeqToMessages(db *sql.DB) error {
    addColumn := `
    ALTER TABLE messages
    ADD COLUMN IF NOT EXISTS seq BIGINT;
    `
    if _, err := db.Exec(addColumn); err != nil {
        return fmt.Errorf("add seq column: %w", err)
    }

    createSeq := `CREATE SEQUENCE IF NOT EXISTS messages_seq_seq;`
    if _, err := db.Exec(createSeq); err != nil {
        return fmt.Errorf("create seq sequence: %w", err)
    }

    backfill := `
    WITH ordered AS (
        SELECT id,
            ROW_NUMBER() OVER (ORDER BY created_at ASC, id ASC) AS rn
        FROM messages
        WHERE seq IS NULL
    )
    UPDATE messages m
    SET seq = o.rn + COALESCE((SELECT last_value FROM messages_seq_seq), 0)
    FROM ordered o
    WHERE m.id = o.id;
    `
    if _, err := db.Exec(backfill); err != nil {
        return fmt.Errorf("backfill seq: %w", err)
    }

    setSeq := `
    SELECT setval(
        'messages_seq_seq',
        COALESCE((SELECT MAX(seq) FROM messages), 0) + 1,
        false
    );
    `
    if _, err := db.Exec(setSeq); err != nil {
        return fmt.Errorf("set seq value: %w", err)
    }

    alterDefaults := `
    ALTER TABLE messages
        ALTER COLUMN seq SET DEFAULT nextval('messages_seq_seq'),
        ALTER COLUMN seq SET NOT NULL;

    ALTER SEQUENCE messages_seq_seq OWNED BY messages.seq;
    `
    if _, err := db.Exec(alterDefaults); err != nil {
        return fmt.Errorf("set seq defaults: %w", err)
    }

    uniqueIdx := `
    CREATE UNIQUE INDEX IF NOT EXISTS idx_messages_seq_unique ON messages(seq);
    `
    if _, err := db.Exec(uniqueIdx); err != nil {
        return fmt.Errorf("create unique seq index: %w", err)
    }

    rangeIdx := `
    CREATE INDEX IF NOT EXISTS idx_messages_chat_seq
        ON messages(chat_id, seq)
        WHERE NOT is_deleted;
    `
    if _, err := db.Exec(rangeIdx); err != nil {
        return fmt.Errorf("create chat_seq index: %w", err)
    }

    log.Println("Migration 002: Added seq to messages successfully!")
    return nil
}
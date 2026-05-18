package migrations

import (
    "database/sql"
    "log"
)

func RunMigrations(db *sql.DB) error {
    migrations := []struct {
        name string
        fn   func(*sql.DB) error
    }{
        {"001_add_updated_at_messages", AddUpdatedAtToMessages},
    }

    for _, m := range migrations {
        log.Printf("Running migration: %s", m.name)
        if err := m.fn(db); err != nil {
            return err
        }
    }

    log.Println("All migrations completed successfully!")
    return nil
}
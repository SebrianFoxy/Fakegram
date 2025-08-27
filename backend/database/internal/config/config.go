package config

import (
    "os"
    "log"

    "github.com/joho/godotenv"
)

type Config struct {
    DBHost     string
    DBPort     string
    DBUser     string
    DBPassword string
    DBName     string
    ServerPort string
}

func LoadConfig() *Config {
    err := godotenv.Load()
    if err != nil {
        log.Printf("Warning: Error loading .env file: %v", err)
    } else {
        log.Println("Successfully loaded .env file")
    }

    config := &Config{
        DBHost:     getEnv("DB_HOST", "localhost"),
        DBPort:     getEnv("DB_PORT", "5432"),
        DBUser:     getEnv("DB_USER", "postgres"),
        DBPassword: getEnv("DB_PASSWORD", "password"),
        DBName:     getEnv("DB_NAME", "mydb"),
        ServerPort: getEnv("SERVER_PORT", "8080"),
    }

    log.Printf("Config loaded: DB_HOST=%s, DB_NAME=%s, DB_USER=%s", 
        config.DBHost, config.DBName, config.DBUser)

    return config
}

func getEnv(key, defaultValue string) string {
    if value, exists := os.LookupEnv(key); exists {
        return value
    }
    return defaultValue
}
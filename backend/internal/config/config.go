package config

import (
	"log"
	"os"

	"github.com/golang-jwt/jwt/v5"
	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
    echojwt "github.com/labstack/echo-jwt/v4" 
)

type Config struct {
    DBHost        string
    DBPort        string
    DBUser        string
    DBPassword    string
    DBName        string
    ServerPort    string
    SMTPHost      string
    SMTPPort      string
    SMTPUsername  string
    SMTPPassword  string
    SMTPFromEmail string
    JWTSecret     string
    DomainHost    string
}

func LoadConfig() *Config {
    err := godotenv.Load()
    if err != nil {
        log.Printf("Warning: Error loading .env file: %v", err)
    } else {
        log.Println("Successfully loaded .env file")
    }

    config := &Config{
        DBHost:        getEnv("DB_HOST", ""),
        DBPort:        getEnv("DB_PORT", ""),
        DBUser:        getEnv("DB_USER", ""),
        DBPassword:    getEnv("DB_PASSWORD", ""),
        DBName:        getEnv("DB_NAME", ""),
        ServerPort:    getEnv("SERVER_PORT", "8080"),
        JWTSecret:     getEnv("JWT_SECRET", ""),
        SMTPHost:      getEnv("SMTP_HOST", "smtp.gmail.com"),
        SMTPPort:      getEnv("SMTP_PORT", "587"),
        SMTPUsername:  getEnv("SMTP_USERNAME", ""),
        SMTPPassword:  getEnv("SMTP_PASSWORD", ""),
        SMTPFromEmail: getEnv("SMTP_FROM_EMAIL", ""),
        DomainHost:    getEnv("DOMAIN_HOST", "localhost:8080"),
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

func (c *Config) GetJWTConfig() echojwt.Config {
    return echojwt.Config{
        SigningKey: []byte(c.JWTSecret),
        TokenLookup: "header:Authorization:Bearer ",
        NewClaimsFunc: func(c echo.Context) jwt.Claims {
            return &jwt.RegisteredClaims{}
        },
        SuccessHandler: func(c echo.Context) {
            token := c.Get("user").(*jwt.Token)
            claims := token.Claims.(*jwt.RegisteredClaims)
            c.Set("userID", claims.Subject)
        },
        ErrorHandler: func(c echo.Context, err error) error {
            return c.JSON(401, map[string]string{
                "error": "Invalid or expired token",
            })
        },
    }
}

func (c *Config) CreateJWTMiddleware() echo.MiddlewareFunc {
    return echojwt.WithConfig(c.GetJWTConfig())
}
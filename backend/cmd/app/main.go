package main

import (
	"database/sql"
	"fmt"
	"log"

	"fakegram-api/internal/config"
	"fakegram-api/internal/database"
	"fakegram-api/internal/database/migrations"
	"fakegram-api/internal/handlers"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/routes"
	"fakegram-api/internal/services"
	"fakegram-api/internal/websocket"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	echoSwagger "github.com/swaggo/echo-swagger"

	_ "fakegram-api/docs"
)

// @title Fakegram API
// @version 1.0
// @description API с JWT авторизацией
// @securityDefinitions.apikey BearerAuth
// @in header
// @name Authorization
// @description Type "Bearer" followed by a space and JWT token.

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.CORS())

	e.GET("/swagger/*", echoSwagger.WrapHandler)
	
	cnf := config.LoadConfig()

	db, err := database.InitDB(cnf)
	if err != nil {
		log.Fatalf("Failed to initialize database: %v", err)
	}
	defer db.Close()

	if err := initDatabase(db); err != nil {
		log.Fatalf("Database initialization failed: %v", err)
	}
	
	userRepo := repositories.NewUserRepository(db)
	tokenRepo := repositories.NewTokenRepository(db)
	chatRepo := repositories.NewChatRepository(db)
	messageRepo := repositories.NewMessageRepository(db)
	cryptoRepo := repositories.NewEncryptionKeyRepository(db)
	deviceRepo := repositories.NewUserDeviceRepository(db)

	keyCacheService, err := services.NewKeyCache(cnf.RedisURL, cnf.KeyCacheTTL)
	if err != nil {
		log.Printf("Warning: Redis unavailable, key caching disabled: %v", err)
		keyCacheService = nil
	}

	cryptoService, err := services.NewCryptoService(cnf, cryptoRepo, deviceRepo, keyCacheService)
	if err != nil {
		log.Fatalf("Failed to initialize crypto service: %v", err)
	}

	userService := services.NewUserService(userRepo)
	tokenService := services.NewTokenService([]byte(cnf.JWTSecret), tokenRepo)
	messageService := services.NewMessageService(messageRepo, chatRepo, nil, nil, *cryptoService)
	chatService := services.NewChatService(chatRepo, nil, *cryptoService)
	emailVerificationService := services.NewEmailVerificationService(
		cnf.SMTPHost,
		cnf.SMTPPort,
		cnf.SMTPUsername,
		cnf.SMTPPassword,
		cnf.SMTPFromEmail,
		cnf.DomainHost,
		[]byte(cnf.JWTSecret),
	)

	wsManager := websocket.NewWebSocketManager(tokenService, messageService, chatService)
	wsHandler := wsManager.GetHandler()

	jwtMiddleware := cnf.CreateJWTMiddleware()

	userHandler := handlers.NewUserHandler(userService)
	authHandler := handlers.NewAuthHandler(userService, tokenService, emailVerificationService, cryptoService)
	messageHandler := handlers.NewMessageHandler(messageService)
	chatHandler := handlers.NewChatHandler(chatService)

	appRoutes := routes.NewRoutes(
		userHandler, 
		authHandler,
		messageHandler,
		chatHandler,
		wsHandler, 
		jwtMiddleware,
	)
	appRoutes.Setup(e)

	port := ":" + cnf.ServerPort
	log.Printf("Server starting on http://localhost%s", port)
	log.Printf("Swagger UI: http://localhost%s/swagger/index.html", port)
	
	if err := e.Start(port); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}

func initDatabase(db *sql.DB) error {
	tables := []struct {
		name string
		fn   func(*sql.DB) error
	}{
		{"users", database.CreateTableUsers},
		{"chats", database.CreateTableChats},
		{"chat members", database.CreateTableChatMembers},
		{"messages", database.CreateTableMessages},
		{"tokens", database.CreateTableTokens},
		{"message read status", database.CreateTableMessageReadStatus},
		{"encrypt master keys", database.CreateTableEncryptMasterKeys},
		{"users devices", database.CreateTableUsersDevices},
	}

	for _, t := range tables {
		if err := t.fn(db); err != nil {
			return fmt.Errorf("failed to create %s table: %w", t.name, err)
		}
	}

	if err := migrations.RunMigrations(db); err != nil {
		return fmt.Errorf("failed to run migrations: %w", err)
	}

	return nil
}
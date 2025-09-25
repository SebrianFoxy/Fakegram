package main

import (
	"log"

	"fakegram-api/internal/config"
	"fakegram-api/internal/database"
	"fakegram-api/internal/handlers"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/routes"
	"fakegram-api/internal/services"

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

	err = database.CreateTableUsers(db)
	if err != nil {
		log.Fatalf("Failed to create users table: %v", err)
	}
	
	err = database.CreateTableMessages(db)
	if err != nil {
		log.Fatalf("Failed to create messages table: %v", err)
	}

	err = database.CreateTableTokens(db)
	if err != nil {
		log.Fatalf("Failed to create tokens table: %v", err)
	}

	userRepo := repositories.NewUserRepository(db)
	tokenRepo := repositories.NewTokenRepository(db)

	jwtMiddleware := cnf.CreateJWTMiddleware()

	tokenService := services.NewTokenService([]byte(cnf.JWTSecret))
	emailVerificationService := services.NewEmailVerificationService(
		cnf.SMTPHost,
		cnf.SMTPPort,
		cnf.SMTPUsername,
		cnf.SMTPPassword,
		cnf.SMTPFromEmail,
		cnf.DomainHost,
		[]byte(cnf.JWTSecret),
	)


	userHandler := handlers.NewUserHandler(userRepo)
	authHandler := handlers.NewAuthHandler(userRepo, tokenRepo, tokenService, emailVerificationService)

	appRoutes := routes.NewRoutes(userHandler, authHandler, jwtMiddleware)
	appRoutes.Setup(e)

	port := ":" + cnf.ServerPort
	log.Printf("Server starting on http://localhost%s", port)
	log.Printf("Swagger UI: http://localhost%s/swagger/index.html", port)
	
	if err := e.Start(port); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
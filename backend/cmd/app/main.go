package main

import (
	"log"

	"fakegram-api/internal/config"
	"fakegram-api/internal/database"
	"fakegram-api/internal/handlers"
	"fakegram-api/internal/repositories"
	"fakegram-api/internal/routes"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	echoSwagger "github.com/swaggo/echo-swagger"

	_ "fakegram-api/docs"
)

// @title fakegram API
// @version 1.0
// @description

// @contact.name   API Support
// @contact.url    http://www.swagger.io/support
// @contact.email  support@swagger.io

// @license.name  Apache 2.0
// @license.url   http://www.apache.org/licenses/LICENSE-2.0.html

// @host      localhost:8080
// @BasePath  /

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

	userHandler := handlers.NewUserHandler(userRepo)
	authHandler := handlers.NewAuthHandler(userRepo, tokenRepo, []byte(cnf.JWTSecret))

	appRoutes := routes.NewRoutes(userHandler, authHandler)
	appRoutes.Setup(e)

	log.Println("Registered routes:")
	for _, route := range e.Routes() {
		log.Printf("%s %s", route.Method, route.Path)
	}

	port := ":" + cnf.ServerPort
	log.Printf("Server starting on http://localhost%s", port)
	log.Printf("Swagger UI: http://localhost%s/swagger/index.html", port)
	
	if err := e.Start(port); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
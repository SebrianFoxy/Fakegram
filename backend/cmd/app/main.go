package main

import (
	"log"

	_ "fakegram-api/docs"
	"fakegram-api/internal/config"
	"fakegram-api/internal/database"
	"fakegram-api/internal/handlers"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	echoSwagger "github.com/swaggo/echo-swagger"
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

	e.GET("/", handlers.Home)
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
	

	e.Logger.Fatal(e.Start(":8080"))
}
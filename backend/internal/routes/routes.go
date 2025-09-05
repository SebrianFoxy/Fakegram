package routes

import (
	"fakegram-api/internal/handlers"

	"github.com/labstack/echo/v4"
	// "github.com/labstack/echo/v4/middleware"
)

type Routes struct {
    userHandler *handlers.UserHandler
	authHandler *handlers.AuthHandler
}

func NewRoutes(userHandler *handlers.UserHandler, authHandler *handlers.AuthHandler) *Routes {
    return &Routes{
        userHandler: userHandler, authHandler: authHandler,
    }
}

func (r *Routes) Setup(e *echo.Echo) {
	v1 := e.Group("/api/v1")
	
	r.setupUserRoutes(v1)
	r.setupAuthRoutes(v1)
}


func (r *Routes) setupUserRoutes(api *echo.Group) {
    users := api.Group("/users")
    
    users.GET("", r.userHandler.GetAllUsers)
	users.POST("", r.userHandler.CreateUser)

}

func (r *Routes) setupAuthRoutes(api *echo.Group){
	auth := api.Group("/auth")

	auth.POST("/login", r.authHandler.LoginUser)
}
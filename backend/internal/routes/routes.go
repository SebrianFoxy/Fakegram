package routes

import (
	"fakegram-api/internal/handlers"

	"github.com/labstack/echo/v4"
	// "github.com/labstack/echo/v4/middleware"
)

type Routes struct {
    userHandler *handlers.UserHandler
}

func NewRoutes(userHandler *handlers.UserHandler) *Routes {
    return &Routes{
        userHandler: userHandler,
    }
}

func (r *Routes) Setup(e *echo.Echo) {
	v1 := e.Group("/api/v1")
	
	r.setupUserRoutes(v1)
}


func (r *Routes) setupUserRoutes(api *echo.Group) {
    users := api.Group("/users")
    
    users.GET("", r.userHandler.GetAllUsers)
	users.POST("", r.userHandler.CreateUser)

}
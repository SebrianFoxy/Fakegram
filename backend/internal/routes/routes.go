package routes

import (
	"fakegram-api/internal/handlers"

	"github.com/labstack/echo/v4"
	// "github.com/labstack/echo/v4/middleware"
)

type Routes struct {
    userHandler *handlers.UserHandler
	authHandler *handlers.AuthHandler
	jwtMiddleware echo.MiddlewareFunc
}

func NewRoutes(
	userHandler *handlers.UserHandler, 
	authHandler *handlers.AuthHandler,
	jwtMiddleware echo.MiddlewareFunc,
	) *Routes {
    return &Routes{
        userHandler: userHandler, 
		authHandler: authHandler,
		jwtMiddleware: jwtMiddleware,
    }
}

func (r *Routes) Setup(e *echo.Echo) {
	v1 := e.Group("/api/v1")
	
	r.setupUserRoutes(v1)
	r.setupAuthRoutes(v1)
}


func (r *Routes) setupUserRoutes(api *echo.Group) {
    users := api.Group("/users")

    users.GET("/all_users", r.userHandler.GetAllUsers, r.jwtMiddleware)
	users.GET("", r.userHandler.GetUser, r.jwtMiddleware)

}

func (r *Routes) setupAuthRoutes(api *echo.Group){
	auth := api.Group("/auth")

	auth.POST("/login", r.authHandler.LoginUser)
	auth.POST("/registration", r.authHandler.RegistrationUser)
	auth.POST("/refresh", r.authHandler.RefreshToken)
	auth.GET("/verify-email", r.authHandler.VerifyEmail)
}
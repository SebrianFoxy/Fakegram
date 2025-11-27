package routes

import (
	"fakegram-api/internal/handlers"
	wsMessage "fakegram-api/internal/websocket/messages"

	"github.com/labstack/echo/v4"
)

type Routes struct {
    userHandler *handlers.UserHandler
	authHandler *handlers.AuthHandler
	messageHandler *handlers.MessageHandler
	chatHandler *handlers.ChatHandler
	wsMessageHandler *wsMessage.MessageWebSocketHandler
	jwtMiddleware echo.MiddlewareFunc
}

func NewRoutes(
	userHandler *handlers.UserHandler, 
	authHandler *handlers.AuthHandler,
	messageHandler *handlers.MessageHandler,
	chatHandler *handlers.ChatHandler,
	wsMessageHandler *wsMessage.MessageWebSocketHandler,
	jwtMiddleware echo.MiddlewareFunc,
	) *Routes {
    return &Routes{
        userHandler: userHandler, 
		authHandler: authHandler,
		messageHandler: messageHandler,
		chatHandler: chatHandler,
		wsMessageHandler: wsMessageHandler,
		jwtMiddleware: jwtMiddleware,
    }
}

func (r *Routes) Setup(e *echo.Echo) {
	v1 := e.Group("/api/v1")
	
	r.setupUserRoutes(v1)
	r.setupAuthRoutes(v1)
	r.setupWebSocketRoutes(v1)
	r.setupChatRoutes(v1)
	r.setupMessageRoutes(v1)
}


func (r *Routes) setupUserRoutes(api *echo.Group) {
    users := api.Group("/users")
	users.Use(r.jwtMiddleware)

    users.GET("/all_users", r.userHandler.GetAllUsers)
	users.GET("", r.userHandler.GetUser)

}

func (r *Routes) setupAuthRoutes(api *echo.Group){
	auth := api.Group("/auth")

	auth.POST("/login", r.authHandler.LoginUser)
	auth.POST("/registration", r.authHandler.RegistrationUser)
	auth.POST("/refresh", r.authHandler.RefreshToken)
	auth.GET("/verify-email", r.authHandler.VerifyEmail)
}

func (r *Routes) setupMessageRoutes(api *echo.Group) {
	messages := api.Group("/messages")
	messages.Use(r.jwtMiddleware)
	
	messages.POST("", r.messageHandler.CreateMessage)
	messages.GET("/private-chat/:user_id", r.messageHandler.GetMessagesByChat)
}

func (r *Routes) setupWebSocketRoutes(e *echo.Group) {
	e.GET("/ws", r.wsMessageHandler.MessageWebSocket, r.jwtMiddleware)
}

func (r *Routes) setupChatRoutes(api *echo.Group) {
	chats := api.Group("/chats")
	chats.Use(r.jwtMiddleware)

	chats.GET("", r.chatHandler.GetUserChats)
}

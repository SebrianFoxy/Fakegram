package types

import "encoding/json"

type Message struct {
    Type    string          `json:"type"`
    Payload json.RawMessage `json:"payload"`
}

type WSEvent struct {
    Event string      `json:"event"`
    Data  interface{} `json:"data"`
}

type UserNotConnectedError struct {
    UserID string
}

func (e *UserNotConnectedError) Error() string {
    return "user " + e.UserID + " is not connected"
}
package utils

import (
    "encoding/json"
    "log"
)

func MustMarshal(v interface{}) json.RawMessage {
    data, err := json.Marshal(v)
    if err != nil {
        log.Printf("WebSocket Marshal error: %v", err)
        return json.RawMessage(`{"error": "marshal_failed"}`)
    }
    return data
}

func SafeUnmarshal(data json.RawMessage, v interface{}) error {
    if err := json.Unmarshal(data, v); err != nil {
        log.Printf("WebSocket Unmarshal error: %v", err)
        return err
    }
    return nil
}

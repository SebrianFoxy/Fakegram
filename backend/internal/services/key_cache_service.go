package services

import (
	"context"
	"encoding/base64"
	"fmt"
	"strconv"
	"time"

	"github.com/redis/go-redis/v9"
)

type keyCache struct {
	redis *redis.Client
	ttl   time.Duration
}

func NewKeyCache(redisURL string, ttlSeconds string) (KeyCacheService, error) {
	if redisURL == "" {
		return nil, fmt.Errorf("redis URL is empty")
	}

	ttl, err := strconv.Atoi(ttlSeconds)
	if err != nil || ttl <= 0 {
		ttl = 2592000
	}

	client := redis.NewClient(&redis.Options{
		Addr: redisURL,
	})

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = client.Ping(ctx).Result()
	if err != nil {
		return nil, fmt.Errorf("failed to connect to Redis: %w", err)
	}

	return &keyCache{
		redis: client,
		ttl:   time.Duration(ttl) * time.Second,
	}, nil
}

func (c *keyCache) SetMasterKey(userID string, key []byte) error {
	encoded := base64.StdEncoding.EncodeToString(key)
	return c.redis.Set(
		context.Background(),
		fmt.Sprintf("master_key:%s", userID),
		encoded,
		c.ttl,
	).Err()
}

func (c *keyCache) GetMasterKey(userID string) ([]byte, error) {
	encoded, err := c.redis.Get(
		context.Background(),
		fmt.Sprintf("master_key:%s", userID),
	).Result()
	if err != nil {
		return nil, fmt.Errorf("key not found in cache: %w", err)
	}
	return base64.StdEncoding.DecodeString(encoded)
}

func (c *keyCache) DeleteMasterKey(userID string) error {
	return c.redis.Del(
		context.Background(),
		fmt.Sprintf("master_key:%s", userID),
	).Err()
}

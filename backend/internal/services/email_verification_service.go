package services

import (
	"bytes"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"html/template"
	"net/smtp"
	"path/filepath"
	"strings"
	"time"
)

type EmailVerificationService struct {
	smtpHost     string
	smtpPort     string
    smtpUsername string
    smtpPassword string
	fromEmail    string
	domainHost	 string
    jwtKey 		 []byte
	templates    *template.Template
}

func NewEmailVerificationService(
	smtpHost string, 
	smtpPort string, 
	smtpUsername string, 
	smtpPassword string, 
	fromEmail string, 
	domainHost string, 
	jwtKey []byte ) *EmailVerificationService {
		
	templatesPath := filepath.Join("internal", "templates", "verification")
    
    templates := template.Must(template.ParseFiles(
        filepath.Join(templatesPath, "verification_success.html"),
        filepath.Join(templatesPath, "verification_error.html"),
    ))
	
    return &EmailVerificationService{
		smtpHost:     smtpHost,
        smtpPort:     smtpPort,
        smtpUsername: smtpUsername,
        smtpPassword: smtpPassword,
        fromEmail:    fromEmail,
        domainHost:   domainHost,
        jwtKey: 	  jwtKey,
		templates:    templates,
    }
}

type EmailVerificationToken struct {
    UserID    string    `json:"user_id"`
    Email     string    `json:"email"`
    Type      string    `json:"type"`
    ExpiresAt int64     `json:"expires_at"`
}

func (s *EmailVerificationService) SendVerificationEmail(toEmail, userID string) error {
    token, err := s.generateVerificationToken(userID, toEmail)
    if err != nil {
        return err
    }
    
    verificationURL := fmt.Sprintf("http://%s:8080/api/v1/auth/verify-email?token=%s", s.domainHost, token)
	subject := "Подтверждение email адреса - FakeGram"
    body := fmt.Sprintf(`
        <h1>Подтверждение регистрации</h1>
        <p>Для подтверждения вашего email адреса перейдите по ссылке:</p>
        <a href="%s">%s</a>
        <p>Ссылка действительна в течение 24 часов.</p>
    `, verificationURL, verificationURL)

    return s.sendEmail(toEmail, subject, body)
}

func (s *EmailVerificationService) sendEmail(to, subject, body string) error {
    msg := bytes.NewBuffer(nil)
    msg.WriteString(fmt.Sprintf("From: %s\r\n", s.fromEmail))
    msg.WriteString(fmt.Sprintf("To: %s\r\n", to))
    msg.WriteString(fmt.Sprintf("Subject: %s\r\n", subject))
    msg.WriteString("MIME-version: 1.0;\r\n")
    msg.WriteString("Content-Type: text/html; charset=\"UTF-8\";\r\n")
    msg.WriteString("\r\n")
    msg.WriteString(body)

    auth := smtp.PlainAuth("", s.smtpUsername, s.smtpPassword, s.smtpHost)

    err := smtp.SendMail(
        s.smtpHost+":"+s.smtpPort,
        auth,
        s.fromEmail,
        []string{to},
        msg.Bytes(),
    )

    if err != nil {
        return fmt.Errorf("failed to send email: %w", err)
    }

    return nil
}

func (s *EmailVerificationService) generateVerificationToken(userID, email string) (string, error) {
    expiresAt := time.Now().Add(24 * time.Hour).Unix()
    
    tokenData := EmailVerificationToken{
        UserID:    userID,
        Email:     email,
        Type:      "verification",
        ExpiresAt: expiresAt,
    }
    
    jsonData, err := json.Marshal(tokenData)
    if err != nil {
        return "", err
    }
    
    signature := s.signToken(jsonData)
    encodedData := base64.URLEncoding.EncodeToString(jsonData)
    encodedSig := base64.URLEncoding.EncodeToString(signature)
    
    return fmt.Sprintf("%s.%s", encodedData, encodedSig), nil
}

func (s *EmailVerificationService) signToken(data []byte) []byte {
    h := hmac.New(sha256.New, s.jwtKey)
    h.Write(data)
    return h.Sum(nil)
}

func (s *EmailVerificationService) VerifyToken(token string) (*EmailVerificationToken, error) {
    parts := strings.Split(token, ".")
    if len(parts) != 2 {
        return nil, fmt.Errorf("invalid token format")
    }
    
    decodedData, err := base64.URLEncoding.DecodeString(parts[0])
    if err != nil {
        return nil, fmt.Errorf("invalid token data")
    }
    
    expectedSig := s.signToken(decodedData)
    decodedSig, err := base64.URLEncoding.DecodeString(parts[1])
    if err != nil {
        return nil, fmt.Errorf("invalid token signature")
    }
    
    if !hmac.Equal(expectedSig, decodedSig) {
        return nil, fmt.Errorf("invalid token signature")
    }
    
    var tokenData EmailVerificationToken
    if err := json.Unmarshal(decodedData, &tokenData); err != nil {
        return nil, fmt.Errorf("invalid token data")
    }
    
    if time.Now().Unix() > tokenData.ExpiresAt {
        return nil, fmt.Errorf("token expired")
    }
    
    return &tokenData, nil
}

func (s *EmailVerificationService) RenderVerificationSuccess() (string, error) {
    var buf bytes.Buffer
    err := s.templates.ExecuteTemplate(&buf, "verification_success.html", nil)
    if err != nil {
        return "", err
    }
    return buf.String(), nil
}

func (s *EmailVerificationService) RenderVerificationError() (string, error) {
    var buf bytes.Buffer
    err := s.templates.ExecuteTemplate(&buf, "verification_error.html", nil)
    if err != nil {
        return "", err
    }
    return buf.String(), nil
}
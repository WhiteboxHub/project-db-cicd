CREATE TABLE IF NOT EXISTS email_sender_engine (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    engine_name VARCHAR(100) NOT NULL
        COMMENT 'UI-friendly name (SMTP-Gmail-1, AWS-SES-Primary)',

    provider VARCHAR(30) NOT NULL
        COMMENT 'smtp | aws_ses | sendgrid | mailgun',

    is_active TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '1 = active, 0 = disabled via UI',

    priority INT NOT NULL DEFAULT 1
        COMMENT 'Lower value = higher priority',

    credentials_json JSON NOT NULL
        COMMENT 'Provider credentials & config',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_engine_active_priority (is_active, priority),
    INDEX idx_engine_provider (provider)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='Email sender engines managed via UI';

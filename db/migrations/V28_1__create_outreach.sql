CREATE TABLE outreach_contacts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    email VARCHAR(255) NOT NULL,
    email_lc VARCHAR(255) GENERATED ALWAYS AS (LOWER(email)) STORED,

    source_type VARCHAR(50) NOT NULL,
    source_id BIGINT NULL,

    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',

    unsubscribe_flag BOOLEAN NOT NULL DEFAULT FALSE,
    unsubscribe_at TIMESTAMP NULL,
    unsubscribe_reason VARCHAR(255) NULL,

    bounce_flag BOOLEAN NOT NULL DEFAULT FALSE,
    bounce_type VARCHAR(20) NULL,
    bounce_reason VARCHAR(255) NULL,
    bounce_code VARCHAR(100) NULL,
    bounced_at TIMESTAMP NULL,

    complaint_flag BOOLEAN NOT NULL DEFAULT FALSE,
    complained_at TIMESTAMP NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY uq_outreach_email (email_lc),
    INDEX idx_outreach_status (status),
    INDEX idx_outreach_unsub (unsubscribe_flag),
    INDEX idx_outreach_bounce (bounce_flag),
    INDEX idx_outreach_complaint (complaint_flag)
);

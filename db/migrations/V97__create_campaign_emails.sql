CREATE TABLE campaign_emails (
    id BIGINT NOT NULL AUTO_INCREMENT,
    workflow_id BIGINT NOT NULL,
    candidate_id INT NOT NULL,
    vendor_email VARCHAR(150) NOT NULL,
    -- State Tracking
    status ENUM (
        'pending',
        'processing',
        'sent',
        'failed',
        'bounced'
    ) NOT NULL DEFAULT 'pending',
    retry_count INT NOT NULL DEFAULT 0,
    last_attempt_at DATETIME DEFAULT NULL,
    run_log_id BIGINT DEFAULT NULL,
    credential_id INT DEFAULT NULL,
    message_id VARCHAR(255) DEFAULT NULL,
    error_message TEXT,
    -- Timestamps
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    -- Normalize email (avoid case issues)
    UNIQUE KEY uq_campaign_email_dedup (workflow_id, candidate_id, vendor_email),
    -- Indexes for performance
    KEY idx_status (status),
    KEY idx_lookup (workflow_id, candidate_id),
    KEY idx_retry (status, retry_count),
    -- Foreign Keys
    CONSTRAINT fk_campaign_email_workflow FOREIGN KEY (workflow_id) REFERENCES automation_workflows (id) ON DELETE CASCADE,
    CONSTRAINT fk_campaign_email_log FOREIGN KEY (run_log_id) REFERENCES automation_workflow_logs (id) ON DELETE SET NULL,
    CONSTRAINT fk_campaign_email_credential FOREIGN KEY (credential_id) REFERENCES email_smtp_credentials (id) ON DELETE SET NULL
);
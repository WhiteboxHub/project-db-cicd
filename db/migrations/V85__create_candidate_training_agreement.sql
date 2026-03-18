CREATE TABLE IF NOT EXISTS candidate_training_agreement (
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id            INT NOT NULL,
    docuseal_submission_id  VARCHAR(255) UNIQUE NOT NULL,
    status                  VARCHAR(50) DEFAULT 'pending',
    drive_file_link         VARCHAR(2048),
    ip_address              VARCHAR(45),
    user_agent              TEXT,
    signed_at               DATETIME NULL,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_candidate_agreement
        FOREIGN KEY (candidate_id)
        REFERENCES candidates(id)
        ON DELETE CASCADE
);
CREATE TABLE application_report (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    candidate_name  VARCHAR(150),
    company_name    VARCHAR(200),
    ats_platform    VARCHAR(100),
    total_fields    INT,
    autofill_fields INT,
    llm_fields      INT,
    human_fields    INT,
    automation_rate DECIMAL(5,2),
    submitted_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_candidate (candidate_name),
    INDEX idx_submitted_at (submitted_at)
);

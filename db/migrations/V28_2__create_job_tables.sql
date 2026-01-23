CREATE TABLE job_definition (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    job_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

    candidate_marketing_id INT NOT NULL,
    config_json JSON NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_jobdef_type (job_type),
    INDEX idx_jobdef_candidate (candidate_marketing_id),
    FOREIGN KEY (candidate_marketing_id)
        REFERENCES candidate_marketing(id)
        ON DELETE CASCADE
);

CREATE TABLE job_schedule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    job_definition_id BIGINT NOT NULL,

    timezone VARCHAR(64) NOT NULL DEFAULT 'America/Los_Angeles',
    frequency VARCHAR(20) NOT NULL,
    interval_value INT NOT NULL DEFAULT 1,

    next_run_at TIMESTAMP NOT NULL,
    last_run_at TIMESTAMP NULL,

    lock_token VARCHAR(64),
    lock_expires_at TIMESTAMP NULL,

    enabled BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (job_definition_id)
        REFERENCES job_definition(id)
        ON DELETE CASCADE,

    INDEX idx_jobsched_next (enabled, next_run_at)
);

CREATE TABLE job_run (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    job_definition_id BIGINT NOT NULL,
    job_schedule_id BIGINT NOT NULL,

    run_status VARCHAR(20) NOT NULL DEFAULT 'RUNNING',
    started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_at TIMESTAMP NULL,

    items_total INT DEFAULT 0,
    items_succeeded INT DEFAULT 0,
    items_failed INT DEFAULT 0,

    error_message TEXT,
    details_json JSON,

    FOREIGN KEY (job_definition_id) REFERENCES job_definition(id),
    FOREIGN KEY (job_schedule_id) REFERENCES job_schedule(id)
);

CREATE TABLE job_request (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    job_type VARCHAR(50) NOT NULL,
    candidate_marketing_id INT NOT NULL,

    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP NULL,

    UNIQUE KEY uq_jobreq (job_type, candidate_marketing_id, status)
);

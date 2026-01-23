CREATE TABLE IF NOT EXISTS `candidate_marketing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `candidate_id` int NOT NULL,
  `start_date` date NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `last_mod_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `marketing_manager` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `imap_password` varchar(50) DEFAULT NULL,
  `google_voice_number` varchar(100) DEFAULT NULL,
  `linkedin_username` varchar(100) DEFAULT NULL,
  `linkedin_passwd` varchar(100) DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `notes` text,
  `move_to_placement` tinyint(1) DEFAULT '0',
  `resume_url` varchar(255) DEFAULT NULL,
  `linkedin_premium_end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marketing_manager` (`marketing_manager`),
  KEY `idx_candidate_id` (`candidate_id`),
  CONSTRAINT `candidate_marketing_ibfk_4` FOREIGN KEY (`marketing_manager`) REFERENCES `employee` (`id`),
  CONSTRAINT `fk_candidate_marketing` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_marketing_manager` FOREIGN KEY (`marketing_manager`) REFERENCES `employee` (`id`),
  CONSTRAINT `chk_priority` CHECK ((`priority` in (1,2,3,4,5)))
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Candidate marketing phase tracking';

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

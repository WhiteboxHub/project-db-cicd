CREATE TABLE raw_position (
  id BIGINT NOT NULL AUTO_INCREMENT,
  source VARCHAR(50) NOT NULL COMMENT 'linkedin, email, job_board, scraper',
  source_uid VARCHAR(255) DEFAULT NULL COMMENT 'external job id or message id',
  extracted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  extractor_version VARCHAR(50) DEFAULT NULL,
  raw_title VARCHAR(500) DEFAULT NULL,
  raw_company VARCHAR(255) DEFAULT NULL,
  raw_location VARCHAR(255) DEFAULT NULL,
  raw_zip VARCHAR(20) DEFAULT NULL,
  raw_description MEDIUMTEXT,
  raw_contact_info TEXT COMMENT 'emails, phones, linkedin, free text',
  raw_notes TEXT COMMENT 'any additional extractor notes',
  raw_payload JSON DEFAULT NULL COMMENT 'full extractor payload if available',
  processing_status ENUM('new','parsed','mapped','discarded','error') NOT NULL DEFAULT 'new',
  error_message TEXT DEFAULT NULL,
  processed_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_source_uid (source, source_uid),
  KEY idx_processing_status (processing_status),
  KEY idx_extracted_at (extracted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Raw extracted job positions';


CREATE TABLE position (
  id BIGINT NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  normalized_title VARCHAR(255) DEFAULT NULL COMMENT 'standardized role name',
  company_name VARCHAR(255) NOT NULL,
  company_id INT DEFAULT NULL COMMENT 'future reference to company table',
  position_type ENUM('full_time','contract','contract_to_hire','internship') DEFAULT NULL,
  employment_mode ENUM('onsite','hybrid','remote') DEFAULT NULL,
  source VARCHAR(50) NOT NULL COMMENT 'linkedin, job_board, vendor, email',
  source_uid VARCHAR(255) DEFAULT NULL,
  location VARCHAR(255) DEFAULT NULL,
  city VARCHAR(100) DEFAULT NULL,
  state VARCHAR(100) DEFAULT NULL,
  zip VARCHAR(20) DEFAULT NULL,
  country VARCHAR(100) DEFAULT NULL,
  contact_email VARCHAR(255) DEFAULT NULL,
  contact_phone VARCHAR(50) DEFAULT NULL,
  contact_linkedin VARCHAR(255) DEFAULT NULL,
  job_url VARCHAR(500) DEFAULT NULL,
  description MEDIUMTEXT,
  notes TEXT,
  status ENUM('open','closed','on_hold','duplicate','invalid') NOT NULL DEFAULT 'open',
  confidence_score DECIMAL(5,2) DEFAULT NULL COMMENT 'extraction or matching confidence',
  created_from_raw_id BIGINT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uniq_source_job (source, source_uid),
  KEY idx_company (company_name),
  KEY idx_status (status),
  KEY idx_location (state, city, zip),
  CONSTRAINT fk_position_raw
    FOREIGN KEY (created_from_raw_id)
    REFERENCES raw_position (id)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cleaned and approved job positions';



CREATE TABLE `job_application_sites` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_name` VARCHAR(100) NOT NULL,
    `domain` VARCHAR(255) UNIQUE NOT NULL,
    `category` ENUM('System integrator', 'Consulting firm', 'Staffing vendor', 'Product Company') NOT NULL,
    
    -- URL & Navigation
    `automation_start_url` TEXT NOT NULL COMMENT 'URL with placeholders like {keyword} or {location}',
    `login_url` VARCHAR(500) DEFAULT NULL,
    
    -- Technical/Platform Details
    `ats_type` VARCHAR(50) DEFAULT NULL COMMENT 'e.g., Workday, Greenhouse, Lever, ICIMS, Custom',
    `automation_suitability` ENUM('Fully automatable', 'Partially automatable', 'Conditional', 'Limited', 'Not recommended') NOT NULL,
    `login_needed` BOOLEAN DEFAULT FALSE,
    `captcha_needed` BOOLEAN DEFAULT FALSE,
    
    -- Bot Detection & Performance
    `proxy_required` BOOLEAN DEFAULT FALSE,
    `user_agent_type` ENUM('Desktop', 'Mobile', 'Any') DEFAULT 'Desktop',
    `average_load_time_ms` INT DEFAULT NULL COMMENT 'To tune script wait_for_selector timeouts',
    
    -- Operational Meta
    `priority` TINYINT DEFAULT 3 COMMENT '1=High, 5=Low. Determines crawl frequency',
    `last_run_status` ENUM('Success', 'Failed', 'Blocked') DEFAULT NULL,
    `last_run_at` DATETIME DEFAULT NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    
    -- Content/Selectors (Optional: could be moved to a JSON column or separate table)
    `selector_config` JSON DEFAULT NULL COMMENT 'Store CSS/Xpath for email_field, submit_btn, etc.',
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_suitability (automation_suitability),
    INDEX idx_ats (ats_type),
    INDEX idx_active_priority (is_active, priority)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
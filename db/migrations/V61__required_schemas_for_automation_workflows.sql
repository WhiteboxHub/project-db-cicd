-- Migration: V61__update_email_extraction_workflow_credentials_sql.sql
-- Description: Updates the credentials_list_sql for the email extraction automation workflow (id=2)
--              to join candidate and candidate_marketing tables and filter by run_email_extraction flag.


-- whitebox_learning.automation_workflows definition

CREATE TABLE IF NOT EXISTS `automation_workflows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_key` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `workflow_type` enum('email_sender','extractor','transformer','webhook','sync') NOT NULL,
  `owner_id` int DEFAULT NULL,
  `status` enum('draft','active','paused','inactive') NOT NULL DEFAULT 'draft',
  `email_template_id` bigint unsigned DEFAULT NULL,
  `delivery_engine_id` bigint unsigned DEFAULT NULL,
  `credentials_list_sql` longtext COMMENT 'SQL to fetch actor credentials',
  `recipient_list_sql` longtext COMMENT 'SQL to fetch target recipients',
  `parameters_config` json DEFAULT NULL COMMENT 'Static config for the job',
  `version` int unsigned NOT NULL DEFAULT '1',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `last_mod_user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_workflow_key` (`workflow_key`),
  KEY `fk_workflow_owner` (`owner_id`),
  KEY `fk_workflow_template` (`email_template_id`),
  KEY `fk_workflow_delivery_engine` (`delivery_engine_id`),
  KEY `idx_workflow_type` (`workflow_type`),
  KEY `idx_workflow_status` (`status`),
  CONSTRAINT `fk_workflow_delivery_engine` FOREIGN KEY (`delivery_engine_id`) REFERENCES `delivery_engines` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_workflow_owner` FOREIGN KEY (`owner_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_workflow_template` FOREIGN KEY (`email_template_id`) REFERENCES `email_templates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- whitebox_learning.delivery_engines definition

CREATE TABLE IF NOT EXISTS `delivery_engines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `engine_type` enum('smtp','mailgun','sendgrid','aws_ses','outlook_api') NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) NOT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `max_recipients_per_run` int unsigned DEFAULT NULL,
  `batch_size` int unsigned DEFAULT '50',
  `rate_limit_per_minute` int unsigned DEFAULT '60',
  `dedupe_window_minutes` int unsigned DEFAULT NULL,
  `retry_policy` json DEFAULT NULL,
  `max_retries` tinyint unsigned NOT NULL DEFAULT '3',
  `timeout_seconds` int unsigned NOT NULL DEFAULT '600',
  `status` enum('active','inactive','deprecated') DEFAULT 'active',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





-- whitebox_learning.email_templates definition

CREATE TABLE IF NOT EXISTS `email_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `template_key` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `subject` varchar(255) NOT NULL,
  `content_html` longtext NOT NULL,
  `content_text` longtext,
  `parameters` json DEFAULT NULL,
  `status` enum('draft','active','inactive') DEFAULT 'draft',
  `version` int unsigned DEFAULT '1',
  `created_time` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `last_mod_time` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `last_mod_user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_template_identity` (`template_key`,`version`),
  KEY `idx_email_templates_status` (`status`),
  KEY `idx_email_templates_lastmod` (`last_mod_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- whitebox_learning.employee definition

CREATE TABLE IF NOT EXISTS `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(150) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `state` varchar(150) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `notes` text,
  `status` tinyint DEFAULT NULL,
  `instructor` tinyint DEFAULT NULL,
  `aadhaar` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `aadhar` (`aadhaar`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8mb3 COMMENT='Employee Management';



-- whitebox_learning.job_activity_log definition

CREATE TABLE IF NOT EXISTS `job_activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_type_id` int NOT NULL,
  `candidate_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `activity_date` date NOT NULL,
  `activity_count` int DEFAULT '0',
  `notes` text,
  `lastmod_user_id` int DEFAULT NULL,
  `lastmod_date_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_type_id`),
  KEY `employee_id` (`employee_id`),
  KEY `fk_job_activity_candidate` (`candidate_id`),
  KEY `idx_job_activity_log_last_mod_user_id` (`lastmod_user_id`),
  KEY `idx_job_activity_log_activity_date` (`activity_date`),
  CONSTRAINT `fk_job_activity_candidate` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_job_activity_log_last_mod_user` FOREIGN KEY (`lastmod_user_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL,
  CONSTRAINT `job_activity_log_ibfk_1` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `job_activity_log_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
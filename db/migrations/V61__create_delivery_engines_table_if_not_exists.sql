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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- whitebox_learning.automation_workflows definition

CREATE TABLE `automation_workflows` (
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
  KEY `idx_owner_id` (`owner_id`),
  KEY `idx_email_template_id` (`email_template_id`),
  KEY `idx_delivery_engine_id` (`delivery_engine_id`),
  KEY `idx_workflow_type` (`workflow_type`),
  KEY `idx_workflow_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
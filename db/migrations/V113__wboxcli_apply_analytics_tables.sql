-- WboxCLI analytics: raw usage events + one grid table (latest apply run per user)

CREATE TABLE IF NOT EXISTS `cli_usage_events` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(255) NOT NULL,
  `event_name` VARCHAR(100) NOT NULL,
  `command` VARCHAR(100) DEFAULT NULL,
  `result` VARCHAR(50) DEFAULT NULL,
  `event_ts` DATETIME NOT NULL,
  `duration_ms` INT DEFAULT NULL,
  `jobs_attempted_count` INT DEFAULT NULL,
  `jobs_submitted_count` INT DEFAULT NULL,
  `jobs_failed_count` INT DEFAULT NULL,
  `event_metadata` JSON DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cli_usage_user_ts` (`user_id`, `event_ts`),
  KEY `idx_cli_usage_command_ts` (`command`, `event_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wboxcli_apply_analytics` (
  `user_id` VARCHAR(255) NOT NULL,
  `jobs_attempted` INT NOT NULL DEFAULT 0,
  `jobs_submitted` INT NOT NULL DEFAULT 0,
  `jobs_failed` INT NOT NULL DEFAULT 0,
  `last_activity` DATETIME NOT NULL,
  `usage_event_id` BIGINT DEFAULT NULL,
  `result` VARCHAR(50) DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `idx_wboxcli_apply_analytics_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

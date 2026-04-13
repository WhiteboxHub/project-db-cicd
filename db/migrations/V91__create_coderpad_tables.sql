
CREATE TABLE IF NOT EXISTS `code_snippet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `authuser_id` int NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT 'Untitled',
  `description` text,
  `language` varchar(50) NOT NULL DEFAULT 'python',
  `code` longtext NOT NULL DEFAULT '',
  `test_cases` json DEFAULT NULL,
  `execution_timeout` int NOT NULL DEFAULT '5',
  `is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `shared_with` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_executed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_code_snippet_authuser` (`authuser_id`),
  CONSTRAINT `fk_code_snippet_authuser` FOREIGN KEY (`authuser_id`) REFERENCES `authuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `code_execution_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_snippet_id` int DEFAULT NULL,
  `authuser_id` int NOT NULL,
  `language` varchar(50) NOT NULL,
  `code_executed` longtext NOT NULL,
  `input_data` text,
  `output` longtext,
  `error` longtext,
  `execution_time_ms` int DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'error',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_code_execution_log_snippet` (`code_snippet_id`),
  KEY `idx_code_execution_log_authuser` (`authuser_id`),
  CONSTRAINT `fk_code_execution_log_snippet` FOREIGN KEY (`code_snippet_id`) REFERENCES `code_snippet` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_code_execution_log_authuser` FOREIGN KEY (`authuser_id`) REFERENCES `authuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `coderpad_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `problem_statement` text NOT NULL,
  `language` varchar(50) NOT NULL DEFAULT 'python',
  `starter_code` longtext NOT NULL DEFAULT '',
  `test_cases` json DEFAULT NULL,
  `assigned_candidate_ids` json DEFAULT NULL,
  `execution_timeout` int NOT NULL DEFAULT '10',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_by_user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_coderpad_question_created_by` (`created_by_user_id`),
  CONSTRAINT `fk_coderpad_question_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `authuser` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- If `coderpad_question` already existed from an older app deploy without `assigned_candidate_ids`, add it.
SET @db := DATABASE();
SET @tbl_exists := (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question'
);
SET @col_exists := (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'coderpad_question'
    AND COLUMN_NAME = 'assigned_candidate_ids'
);
SET @fix_sql := IF(
  @tbl_exists > 0 AND @col_exists = 0,
  'ALTER TABLE `coderpad_question` ADD COLUMN `assigned_candidate_ids` json DEFAULT NULL AFTER `test_cases`',
  'SELECT 1'
);
PREPARE stmt FROM @fix_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================================
-- V118: Create and Refactor AI Prep Tool Tables
--   - Rename existing python-created tables to _legacy as backups
--     (Safely only renames if they are in the old user_id format)
--   - Create clean evaluations, project context, attempts, case studies
--     linked to candidate_marketing via candidate_id INT
-- ============================================================

SET @db := DATABASE();

-- ────────────────────────────────────────────────────────────
-- 1. Backup existing tables to _legacy if they exist in old format
-- ────────────────────────────────────────────────────────────

-- aiprep_tool_candidates (deprecated table - rename if exists)
SET @cand_exists := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_candidates'
);
SET @sql_backup_cand := IF(
    @cand_exists > 0,
    'RENAME TABLE `aiprep_tool_candidates` TO `aiprep_tool_candidates_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_cand; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- aiprep_tool_resumes (deprecated table - rename if exists)
SET @res_exists := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_resumes'
);
SET @sql_backup_res := IF(
    @res_exists > 0,
    'RENAME TABLE `aiprep_tool_resumes` TO `aiprep_tool_resumes_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_res; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- aiprep_tool_evaluations (rename only if it contains the old 'user_id' column)
SET @eval_has_user_id := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db 
      AND TABLE_NAME = 'aiprep_tool_evaluations'
      AND COLUMN_NAME = 'user_id'
);
SET @sql_backup_eval := IF(
    @eval_has_user_id > 0,
    'RENAME TABLE `aiprep_tool_evaluations` TO `aiprep_tool_evaluations_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_eval; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- aiprep_tool_project_context (rename only if it contains the old 'user_id' column)
SET @proj_has_user_id := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db 
      AND TABLE_NAME = 'aiprep_tool_project_context'
      AND COLUMN_NAME = 'user_id'
);
SET @sql_backup_proj := IF(
    @proj_has_user_id > 0,
    'RENAME TABLE `aiprep_tool_project_context` TO `aiprep_tool_project_context_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_proj; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- aiprep_tool_attempts (rename only if it contains the old 'user_id' column)
SET @atm_has_user_id := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db 
      AND TABLE_NAME = 'aiprep_tool_attempts'
      AND COLUMN_NAME = 'user_id'
);
SET @sql_backup_atm := IF(
    @atm_has_user_id > 0,
    'RENAME TABLE `aiprep_tool_attempts` TO `aiprep_tool_attempts_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_atm; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- aiprep_tool_case_studies (rename only if it contains the old 'user_id' column)
SET @cs_has_user_id := (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db 
      AND TABLE_NAME = 'aiprep_tool_case_studies'
      AND COLUMN_NAME = 'user_id'
);
SET @sql_backup_cs := IF(
    @cs_has_user_id > 0,
    'RENAME TABLE `aiprep_tool_case_studies` TO `aiprep_tool_case_studies_legacy`',
    'SELECT 1'
);
PREPARE stmt FROM @sql_backup_cs; EXECUTE stmt; DEALLOCATE PREPARE stmt;


-- ────────────────────────────────────────────────────────────
-- 2. Create clean refactored AI Prep tables
-- ────────────────────────────────────────────────────────────

-- Create AI Prep Tool evaluations table (1-per-candidate, login/intro tracking)
CREATE TABLE IF NOT EXISTS `aiprep_tool_evaluations` (
  `id`             INT NOT NULL AUTO_INCREMENT,
  `candidate_id`   INT NOT NULL,
  `intro_score`    INT DEFAULT NULL COMMENT 'AI-evaluated score for candidate intro video',
  `intro_video`    VARCHAR(500) DEFAULT NULL COMMENT 'URL/path to candidate intro video',
  `intro_status`   ENUM('not_started','in_progress','completed','reviewed') DEFAULT 'not_started',
  `login_count`    INT NOT NULL DEFAULT 0,
  `last_login`     TIMESTAMP NULL DEFAULT NULL,
  `created_at`     TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`     TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_eval_candidate` (`candidate_id`),
  INDEX `idx_eval_candidate` (`candidate_id`),
  CONSTRAINT `fk_eval_candidate_id`
    FOREIGN KEY (`candidate_id`) REFERENCES `candidate_marketing` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='AI Prep Tool per-candidate evaluation and login tracking';

-- Create AI Prep Tool project context table
CREATE TABLE IF NOT EXISTS `aiprep_tool_project_context` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `candidate_id` INT NOT NULL,
  `product` TEXT DEFAULT NULL,
  `architecture` TEXT DEFAULT NULL,
  `business_value` TEXT DEFAULT NULL,
  `role` TEXT DEFAULT NULL,
  `impact` TEXT DEFAULT NULL,
  `business_problem` TEXT DEFAULT NULL,
  `previous_system` TEXT DEFAULT NULL,
  `key_objectives` TEXT DEFAULT NULL,
  `users_scale` TEXT DEFAULT NULL,
  `agents_components` TEXT DEFAULT NULL,
  `key_workflows` TEXT DEFAULT NULL,
  `tools_integrations` TEXT DEFAULT NULL,
  `tech_stack` TEXT DEFAULT NULL,
  `ai_techniques` TEXT DEFAULT NULL,
  `evaluation_approach` TEXT DEFAULT NULL,
  `challenges_learnings` TEXT DEFAULT NULL,
  `safety_guardrails` TEXT DEFAULT NULL,
  `future_roadmap` TEXT DEFAULT NULL,
  `company_name` TEXT DEFAULT NULL,
  `key_problems` TEXT DEFAULT NULL,
  `agent_usage` VARCHAR(50) DEFAULT NULL,
  `learnings` TEXT DEFAULT NULL,
  `domain` VARCHAR(255) DEFAULT NULL,
  `background` TEXT DEFAULT NULL,
  `skills` JSON DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_proj_candidate` (`candidate_id`),
  INDEX `idx_project_candidate` (`candidate_id`),
  CONSTRAINT `fk_proj_candidate_id`
    FOREIGN KEY (`candidate_id`) REFERENCES `candidate_marketing` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool attempts table
CREATE TABLE IF NOT EXISTS `aiprep_tool_attempts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `candidate_id` INT NOT NULL,
  `attempt_type` VARCHAR(50) DEFAULT NULL,
  `attempt_count` INT DEFAULT 0,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_candidate_attempt` (`candidate_id`, `attempt_type`),
  INDEX `idx_attempt_candidate` (`candidate_id`),
  CONSTRAINT `fk_attempt_candidate_id`
    FOREIGN KEY (`candidate_id`) REFERENCES `candidate_marketing` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool case studies table
CREATE TABLE IF NOT EXISTS `aiprep_tool_case_studies` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `candidate_id` INT NOT NULL,
  `content` TEXT DEFAULT NULL,
  `topic` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_case_study_candidate` (`candidate_id`),
  CONSTRAINT `fk_cs_candidate_id`
    FOREIGN KEY (`candidate_id`) REFERENCES `candidate_marketing` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create prep tokens table (one-time sync tokens, replaces Redis)
CREATE TABLE IF NOT EXISTS `prep_tokens` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `token` VARCHAR(36) UNIQUE NOT NULL,
  `candidate_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_prep_token` (`token`),
  CONSTRAINT `fk_tokens_candidate_id`
    FOREIGN KEY (`candidate_id`) REFERENCES `candidate_marketing` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool resumes table
CREATE TABLE IF NOT EXISTS `aiprep_tool_resumes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(255) UNIQUE NOT NULL,
  `resume_json` JSON DEFAULT NULL,
  `resume_pdf_url` VARCHAR(1024) DEFAULT NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_resume_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool project context table
CREATE TABLE IF NOT EXISTS `aiprep_tool_project_context` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(255) UNIQUE NOT NULL,
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
  INDEX `idx_project_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool evaluations table
CREATE TABLE IF NOT EXISTS `aiprep_tool_evaluations` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(255) NOT NULL,
  `type` VARCHAR(50) DEFAULT NULL,
  `score` INT DEFAULT NULL,
  `passed` BOOLEAN DEFAULT NULL,
  `feedback` JSON DEFAULT NULL,
  `raw_response` JSON DEFAULT NULL,
  `video_url` VARCHAR(1024) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_eval_user` (`user_id`),
  INDEX `idx_eval_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool attempts table
CREATE TABLE IF NOT EXISTS `aiprep_tool_attempts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(255) NOT NULL,
  `attempt_type` VARCHAR(50) DEFAULT NULL,
  `attempt_count` INT DEFAULT 0,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uq_user_attempt` (`user_id`, `attempt_type`),
  INDEX `idx_attempt_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create AI Prep Tool case studies table
CREATE TABLE IF NOT EXISTS `aiprep_tool_case_studies` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` VARCHAR(255) NOT NULL,
  `content` TEXT DEFAULT NULL,
  `topic` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_case_study_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create prep tokens table (one-time sync tokens, replaces Redis)
CREATE TABLE IF NOT EXISTS `prep_tokens` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `token` VARCHAR(36) UNIQUE NOT NULL,
  `user_id` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_prep_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ensure video_url column is added if aiprep_tool_evaluations already existed without it
SET @db := DATABASE();
SET @col_video_url_exists := (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'aiprep_tool_evaluations'
    AND COLUMN_NAME = 'video_url'
);
SET @sql_video_url := IF(
  @col_video_url_exists = 0,
  'ALTER TABLE `aiprep_tool_evaluations` ADD COLUMN `video_url` VARCHAR(1024) DEFAULT NULL AFTER `raw_response`',
  'SELECT 1'
);
PREPARE stmt FROM @sql_video_url;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Ensure agent_usage column is added if aiprep_tool_project_context already existed without it
SET @col_agent_usage_exists := (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'aiprep_tool_project_context'
    AND COLUMN_NAME = 'agent_usage'
);
SET @sql_agent_usage := IF(
  @col_agent_usage_exists = 0,
  'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `agent_usage` VARCHAR(50) DEFAULT NULL AFTER `key_problems`',
  'SELECT 1'
);
PREPARE stmt FROM @sql_agent_usage;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Safe alters for project context columns
SET @col_bp_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'business_problem');
SET @sql_bp := IF(@col_bp_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `business_problem` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_bp; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ps_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'previous_system');
SET @sql_ps := IF(@col_ps_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `previous_system` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ps; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ko_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'key_objectives');
SET @sql_ko := IF(@col_ko_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `key_objectives` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ko; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_us_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'users_scale');
SET @sql_us := IF(@col_us_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `users_scale` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_us; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ac_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'agents_components');
SET @sql_ac := IF(@col_ac_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `agents_components` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ac; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_kw_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'key_workflows');
SET @sql_kw := IF(@col_kw_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `key_workflows` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_kw; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ti_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'tools_integrations');
SET @sql_ti := IF(@col_ti_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `tools_integrations` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ti; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ts_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'tech_stack');
SET @sql_ts := IF(@col_ts_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `tech_stack` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ts; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_at_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'ai_techniques');
SET @sql_at := IF(@col_at_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `ai_techniques` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_at; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ea_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'evaluation_approach');
SET @sql_ea := IF(@col_ea_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `evaluation_approach` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ea; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_cl_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'challenges_learnings');
SET @sql_cl := IF(@col_cl_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `challenges_learnings` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_cl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_sg_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'safety_guardrails');
SET @sql_sg := IF(@col_sg_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `safety_guardrails` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_sg; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_fr_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'future_roadmap');
SET @sql_fr := IF(@col_fr_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `future_roadmap` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_fr; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_cn_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'company_name');
SET @sql_cn := IF(@col_cn_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `company_name` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_cn; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_kp_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'key_problems');
SET @sql_kp := IF(@col_kp_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `key_problems` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_kp; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_ln_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'aiprep_tool_project_context' AND COLUMN_NAME = 'learnings');
SET @sql_ln := IF(@col_ln_exists = 0, 'ALTER TABLE `aiprep_tool_project_context` ADD COLUMN `learnings` TEXT DEFAULT NULL', 'SELECT 1');
PREPARE stmt FROM @sql_ln; EXECUTE stmt; DEALLOCATE PREPARE stmt;


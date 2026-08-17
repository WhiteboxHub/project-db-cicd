-- Flyway Migration V130: Add Table Comments (Tables 1 to 30)
-- Target: High-quality functional documentation for active production tables
-- Flyway/JDBC-safe and idempotent: only sets comment when table exists and comment is empty.

SET @tbl = 'aiprep_tool_attempts';
SET @comment = 'Stores candidate mock interview attempt counters partitioned by category to monitor platform usage.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'aiprep_tool_candidates';
SET @comment = 'Stores AI Prep candidate accounts, login credentials, encrypted LLM API keys, and session activity.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'aiprep_tool_case_studies';
SET @comment = 'Stores technical case studies, interview scenarios, and questions assigned during AI Prep sessions.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'aiprep_tool_coderpad_cache';
SET @comment = 'Caches candidate Coderpad performance metrics, including solved questions, submission counts, pass rates, and languages used.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'aiprep_tool_project_context';
SET @comment = 'Stores candidate project architecture, tech stack, and background details used to personalize AI interviews.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'aiprep_tool_resumes';
SET @comment = 'Stores candidate parsed resume JSON data and resume PDF URLs for AI interview personalization.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'automation_contact_extracts';
SET @comment = 'Stores staging recruiter and vendor contacts extracted from automated email digests before deduplication.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'automation_workflows';
SET @comment = 'Stores background automation workflow definitions, configurations, handler classes, and active status.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'batch';
SET @comment = 'Stores training cohort batches, assigned instructors, curriculum mappings, and start/end dates.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate';
SET @comment = 'Stores candidate master profiles including contact details, visa status, skills, and onboarding stage.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate_classes';
SET @comment = 'Stores candidate training class enrollments, attendance, grades, and completion records.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate_interview';
SET @comment = 'Stores candidate interview schedules, company details, round types, interviewer notes, and audio links.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate_llm_api_keys';
SET @comment = 'Stores candidate encrypted LLM provider API keys (OpenAI, Claude, Gemini) and validation statuses.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'company_hr_contacts';
SET @comment = 'Stores contact details, company names, and locations of corporate HR professionals and recruiters, indicating immigration team status.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'employee';
SET @comment = 'Stores internal employee and instructor profiles, including contact details, employment status, roles, and identification numbers.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'employee_task';
SET @comment = 'Stores internal employee task assignments, tracking due dates, priority levels, notes, and execution statuses.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'projects';
SET @comment = 'Stores internal project details, capturing project owners, schedule timelines, priority levels, and execution statuses.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

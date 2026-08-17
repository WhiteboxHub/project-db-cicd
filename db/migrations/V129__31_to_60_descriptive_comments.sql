-- Add comments only when the target table exists.
-- Flyway/JDBC-safe: uses per-table conditional prepared statements and QUOTE().

SET @tbl = 'email_templates';
SET @comment = 'Stores reusable email templates, including subject, HTML and text content, parameters, version, and operational status.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'course';
SET @comment = 'Stores training course definitions, descriptions, aliases, and syllabus information.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'course_content';
SET @comment = 'Stores course content references organized by training areas such as Fundamentals, AI/ML, UI, and Quality Engineering.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'course_material';
SET @comment = 'Stores subject-specific course materials, including names, descriptions, resource types, links, and display order.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'course_subject';
SET @comment = 'Maps courses to their associated training subjects.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'email_activity_log';
SET @comment = 'Stores daily candidate marketing email activity, including emails read and vendor emails extracted.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'company';
SET @comment = 'Stores company profiles, including names, addresses, contact details, domains, notes, and audit information.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'company_contact';
SET @comment = 'Stores contacts associated with companies, including job titles, contact information, addresses, LinkedIn identifiers, and notes.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate_resume';
SET @comment = 'Stores candidate resume data in JSON format, including the source file name and creation and update timestamps.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'candidate_session';
SET @comment = 'Maps candidates to their assigned or attended training sessions.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'cli_usage_events';
SET @comment = 'Stores CLI usage events, command results, execution duration, job-processing totals, and additional event metadata.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'clients';
SET @comment = 'Stores employer and client organization names, addresses, telephone details, and creation timestamps.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'code_execution_log';
SET @comment = 'Stores candidate code execution history, including source code, inputs, outputs, errors, execution status, and duration.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'code_snippet';
SET @comment = 'Stores user-created code snippets, programming language, test cases, sharing configuration, and execution settings.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'coderpad_question';
SET @comment = 'Stores CoderPad assessment questions, problem statements, starter code, test cases, candidate assignments, and execution settings.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl AND TABLE_TYPE = 'BASE TABLE')
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
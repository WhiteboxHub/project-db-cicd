-- Add descriptions only to tables whose comments are currently empty.
-- Flyway/JDBC-safe: no DELIMITER, conditional per-table ALTER.

SET @tbl = 'authuser';
SET @comment = 'Stores application user accounts, authentication details, roles, account status, and login information.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'automation_workflow_logs';
SET @comment = 'Stores automation workflow execution history, status, parameters, processing totals, errors, and timestamps.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'delivery_engines';
SET @comment = 'Stores email delivery engine configuration, sender details, rate limits, retry rules, and operational status.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'email_smtp_credentials';
SET @comment = 'Stores SMTP account configuration and credentials used by application email delivery processes.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'event_logs';
SET @comment = 'Stores scheduled database event execution results, including event name, affected row count, and execution time.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_link_clicks';
SET @comment = 'Stores per-user job listing click activity, including click totals and first and most recent click timestamps.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'outreach_contacts';
SET @comment = 'Stores recruiter and company contacts collected for candidate outreach and marketing activities.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'potential_leads';
SET @comment = 'Stores potential leads identified for review, qualification, assignment, and conversion.';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
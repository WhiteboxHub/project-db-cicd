-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to xxx_candidate_old)
-- =============================================================================
-- Purpose  : Add short, clean 3-point structured comments for all active tables
--            from encrypted_configs to xxx_candidate_old in alphabetical order.
-- Safety   : Avoids stored procedures and DELIMITER so Flyway/JDBC can execute.
--            Only sets comments when the target table exists AND its TABLE_COMMENT is empty.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

-- Pattern repeated per table:
-- SET @tbl = 'table_name';
-- SET @comment = 'comment text';
-- SELECT IF(
--   EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
--   AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
--   CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
--   'SELECT 1'
-- ) INTO @sql;
-- PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'encrypted_configs';
SET @comment = 'App Settings , Encrypted Keys , System Security';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'event_logs';
SET @comment = 'Event Logs , Cleanup History , Database Automation';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'extension_keys';
SET @comment = 'Extension Keys , Device Tokens , Chrome Bot Auth';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'flyway_schema_history';
SET @comment = 'Flyway History , Migration Scripts , Version Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'internal_documents';
SET @comment = 'Internal Docs , Training Guides , Reference Links';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_activity_log';
SET @comment = 'Job Logs , Daily Submissions , Application Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_automation_keywords';
SET @comment = 'Domain Filters , Keyword Rules , Email Extractor';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_link_clicks';
SET @comment = 'Job Clicks , Candidate Views , Usage Analytics';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_listing';
SET @comment = 'Job Postings , Sourced Boards , Application Links';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'job_types';
SET @comment = 'Job Categories , Manual & Bot Tasks , Owner Mapping';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'jobcli_field_answers';
SET @comment = 'Field Answers , Form Auto-Fill , JobCLI Bot';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'jobcli_locators';
SET @comment = 'UI Selectors , ATS Navigation , JobCLI Bot';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'jobcli_sync_versions';
SET @comment = 'Sync Versions , Rule Snapshots , JobCLI Bot';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'lead';
SET @comment = 'Candidate Leads , Contact Info , Work Status';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'linkedin_only_contact';
SET @comment = 'LinkedIn Contacts , Recruiter Profiles , Vendor Sourcing';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'outreach_contacts';
SET @comment = 'Outreach Contacts , Unsubscribe Lists , Bounce Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'outreach_email_recipients';
SET @comment = 'Email Recipients , Delivery Targets , Outreach Campaigns';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'outreach_emails';
SET @comment = 'Outreach Emails , Recruiter Directory , Delivery Status';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'personal_domain_contact';
SET @comment = 'Vendor Contacts , Personal Domains , Recruiter Directory';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'placement_fee_collection';
SET @comment = 'Placement Fees , Installment Dates , Payment Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'potential_leads';
SET @comment = 'Potential Leads , Sourced Profiles , Outreach Status';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'projects';
SET @comment = 'Company Projects , Task Timelines , Owner Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'recording';
SET @comment = 'Session Recordings , Video Links , AI Prep Module';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'recording_batch';
SET @comment = 'Batch Recordings , Group Sessions , AI Prep Module';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'schema_migrations';
SET @comment = 'Schema Versions , Rails Migrations , DB History';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'session';
SET @comment = 'Candidate Sessions , Login Tracking , Class Access';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'subject';
SET @comment = 'Training Subjects , Course Topics , Curriculum Modules';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'submission_events';
SET @comment = 'Submission Events , Application Actions , Tracking Log';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'submissions';
SET @comment = 'Job Submissions , Application Records , ATS Tracking';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'submitters';
SET @comment = 'Submitters Info , Contact Details , Application Source';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'talentscreen_apply_queue';
SET @comment = 'Apply Queue , Talentscreen Jobs , Automation Pipeline';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'template_folders';
SET @comment = 'Email Folders , Template Groups , Outreach Org';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'templates';
SET @comment = 'Email Templates , Outreach Drafts , Campaign Content';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'users';
SET @comment = 'System Users , Auth Accounts , Role Management';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'vendor';
SET @comment = 'Recruiter Contacts , Vendor Directory , Email Sourcing';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'vendor_contact_extracts';
SET @comment = 'Extracted Contacts , Daily Sourcing , Vendor Pipeline';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'wboxcli_apply_analytics';
SET @comment = 'CLI Apply Stats , Job Apply Runs , Automation Analytics';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @tbl = 'xxx_candidate_old';
SET @comment = 'Archived Candidates , Legacy Data , Pre-Migration Records';
SELECT IF(
  EXISTS(SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl)
  AND (SELECT COALESCE(TABLE_COMMENT,'') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @tbl) = '',
  CONCAT('ALTER TABLE `', REPLACE(@tbl,'`','``'), '` COMMENT = ', QUOTE(@comment)),
  'SELECT 1'
) INTO @sql; PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

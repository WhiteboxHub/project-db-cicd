-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to xxx_candidate_old)
-- =============================================================================
-- Purpose  : Add short, clean 3-point structured comments for all active tables
--            from encrypted_configs to xxx_candidate_old in alphabetical order.
--
-- Safety   : Uses a dynamic stored procedure wrapper (add_tbl_comment) that
--            verifies table existence in information_schema before altering.
--            - On CI/CD (fresh testdb) : Safely skips tables not yet migrated.
--            - On Local / Prod (wbl)   : Applies descriptive comments to all tables.
--
-- Verified : Audited against database dump (Dump20260811.sql).
--            Only tables populated with active data are included.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS add_tbl_comment$$

CREATE PROCEDURE add_tbl_comment(
    IN p_table VARCHAR(128),
    IN p_comment VARCHAR(512)
)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.TABLES
        WHERE TABLE_SCHEMA = DATABASE() 
          AND TABLE_NAME = p_table
    ) THEN
        SET @sql_stmt = CONCAT('ALTER TABLE `', p_table, '` COMMENT = ''', p_comment, '''');
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$

DELIMITER ;

-- =============================================================================
-- Active Table Comments (Alphabetical Order: encrypted_configs -> xxx_candidate_old)
-- =============================================================================

-- Table: encrypted_configs (3 rows in dump)
CALL add_tbl_comment('encrypted_configs', 'App Settings , Encrypted Keys , System Security');

-- Table: event_logs (175 rows in dump)
CALL add_tbl_comment('event_logs', 'Event Logs , Cleanup History , Database Automation');

-- Table: extension_keys (4 rows in dump)
CALL add_tbl_comment('extension_keys', 'Extension Keys , Device Tokens , Chrome Bot Auth');

-- Table: flyway_schema_history (124 rows in dump)
CALL add_tbl_comment('flyway_schema_history', 'Flyway History , Migration Scripts , Version Tracking');

-- Table: internal_documents (24 rows in dump)
CALL add_tbl_comment('internal_documents', 'Internal Docs , Training Guides , Reference Links');

-- Table: job_activity_log (644 rows in dump)
CALL add_tbl_comment('job_activity_log', 'Job Logs , Daily Submissions , Application Tracking');

-- Table: job_automation_keywords (103 rows in dump)
CALL add_tbl_comment('job_automation_keywords', 'Domain Filters , Keyword Rules , Email Extractor');

-- Table: job_link_clicks (5,372 rows in dump)
CALL add_tbl_comment('job_link_clicks', 'Job Clicks , Candidate Views , Usage Analytics');

-- Table: job_listing (1,782 rows in dump)
CALL add_tbl_comment('job_listing', 'Job Postings , Sourced Boards , Application Links');

-- Table: job_types (27 rows in dump)
CALL add_tbl_comment('job_types', 'Job Categories , Manual & Bot Tasks , Owner Mapping');

-- Table: jobcli_field_answers (118 rows in dump)
CALL add_tbl_comment('jobcli_field_answers', 'Field Answers , Form Auto-Fill , JobCLI Bot');

-- Table: jobcli_locators (6 rows in dump)
CALL add_tbl_comment('jobcli_locators', 'UI Selectors , ATS Navigation , JobCLI Bot');

-- Table: jobcli_sync_versions (89 rows in dump)
CALL add_tbl_comment('jobcli_sync_versions', 'Sync Versions , Rule Snapshots , JobCLI Bot');

-- Table: lead (5,063 rows in dump)
CALL add_tbl_comment('lead', 'Candidate Leads , Contact Info , Work Status');

-- Table: linkedin_only_contact (734 rows in dump)
CALL add_tbl_comment('linkedin_only_contact', 'LinkedIn Contacts , Recruiter Profiles , Vendor Sourcing');

-- Table: outreach_contacts (2 rows in dump)
CALL add_tbl_comment('outreach_contacts', 'Outreach Contacts , Unsubscribe Lists , Bounce Tracking');

-- Table: outreach_email_recipients (113,512 rows in dump)
CALL add_tbl_comment('outreach_email_recipients', 'Email Recipients , Delivery Targets , Outreach Campaigns');

-- Table: outreach_emails (12,123 rows in dump)
CALL add_tbl_comment('outreach_emails', 'Outreach Emails , Recruiter Directory , Delivery Status');

-- Table: personal_domain_contact (7,494 rows in dump)
CALL add_tbl_comment('personal_domain_contact', 'Vendor Contacts , Personal Domains , Recruiter Directory');

-- Table: placement_fee_collection (96 rows in dump)
CALL add_tbl_comment('placement_fee_collection', 'Placement Fees , Installment Dates , Payment Tracking');

-- Table: potential_leads (221 rows in dump)
CALL add_tbl_comment('potential_leads', 'Potential Leads , Sourced Profiles , Outreach Status');

-- Table: projects (15 rows in dump)
CALL add_tbl_comment('projects', 'Company Projects , Task Timelines , Owner Tracking');

-- Table: recording (6,521 rows in dump)
CALL add_tbl_comment('recording', 'Session Recordings , Video Links , AI Prep Module');

-- Table: recording_batch (11,962 rows in dump)
CALL add_tbl_comment('recording_batch', 'Batch Recordings , Group Sessions , AI Prep Module');

-- Table: schema_migrations (37 rows in dump)
CALL add_tbl_comment('schema_migrations', 'Schema Versions , Rails Migrations , DB History');

-- Table: session (3,116 rows in dump)
CALL add_tbl_comment('session', 'Candidate Sessions , Login Tracking , Class Access');

-- Table: subject (77 rows in dump)
CALL add_tbl_comment('subject', 'Training Subjects , Course Topics , Curriculum Modules');

-- Table: submission_events (2 rows in dump)
CALL add_tbl_comment('submission_events', 'Submission Events , Application Actions , Tracking Log');

-- Table: submissions (2 rows in dump)
CALL add_tbl_comment('submissions', 'Job Submissions , Application Records , ATS Tracking');

-- Table: submitters (2 rows in dump)
CALL add_tbl_comment('submitters', 'Submitters Info , Contact Details , Application Source');

-- Table: talentscreen_apply_queue (10 rows in dump)
CALL add_tbl_comment('talentscreen_apply_queue', 'Apply Queue , Talentscreen Jobs , Automation Pipeline');

-- Table: template_folders (1 row in dump)
CALL add_tbl_comment('template_folders', 'Email Folders , Template Groups , Outreach Org');

-- Table: templates (9 rows in dump)
CALL add_tbl_comment('templates', 'Email Templates , Outreach Drafts , Campaign Content');

-- Table: users (1 row in dump)
CALL add_tbl_comment('users', 'System Users , Auth Accounts , Role Management');

-- Table: vendor (6,095 rows in dump)
CALL add_tbl_comment('vendor', 'Recruiter Contacts , Vendor Directory , Email Sourcing');

-- Table: vendor_contact_extracts (4,454 rows in dump)
CALL add_tbl_comment('vendor_contact_extracts', 'Extracted Contacts , Daily Sourcing , Vendor Pipeline');

-- Table: wboxcli_apply_analytics (9 rows in dump)
CALL add_tbl_comment('wboxcli_apply_analytics', 'CLI Apply Stats , Job Apply Runs , Automation Analytics');

-- Table: xxx_candidate_old (1,194 rows in dump)
CALL add_tbl_comment('xxx_candidate_old', 'Archived Candidates , Legacy Data , Pre-Migration Records');

-- =============================================================================
-- Cleanup Helper Procedure
-- =============================================================================
DROP PROCEDURE IF EXISTS add_tbl_comment;

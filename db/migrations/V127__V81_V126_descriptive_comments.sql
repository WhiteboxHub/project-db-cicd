-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to xxx_candidate_old)
-- =============================================================================
-- Purpose  : Add structured 3-point comments to all tables with active data.
--            Tables in the Flyway migration chain get a direct ALTER TABLE.
--            Tables NOT in the chain use a safe conditional procedure (no-op
--            in CI/CD fresh testdb, applied on production/local wbl).
-- Verified : Audited against Dump20260811.sql and Flyway migration chain V1-V126.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

-- =============================================================================
-- SECTION 1: Tables that exist in the migration chain (direct ALTER TABLE)
-- =============================================================================

-- Table: event_logs (V56 | 175 rows)
ALTER TABLE `event_logs`
  COMMENT = 'Event Logs , Cleanup History , Database Automation';

-- Table: job_automation_keywords (V6 | 103 rows)
ALTER TABLE `job_automation_keywords`
  COMMENT = 'Domain Filters , Keyword Rules , Email Extractor';

-- Table: job_link_clicks (V80 | 5372 rows)
ALTER TABLE `job_link_clicks`
  COMMENT = 'Job Clicks , Candidate Views , Usage Analytics';

-- Table: job_listing (V82 | 1782 rows)
ALTER TABLE `job_listing`
  COMMENT = 'Job Postings , Sourced Boards , Application Links';

-- Table: job_types (V3_1 | 27 rows)
ALTER TABLE `job_types`
  COMMENT = 'Job Categories , Manual and Bot Tasks , Owner Mapping';

-- Table: jobcli_field_answers (V95 | 118 rows)
ALTER TABLE `jobcli_field_answers`
  COMMENT = 'Field Answers , Form Auto-Fill , JobCLI Bot';

-- Table: jobcli_locators (V95 | 6 rows)
ALTER TABLE `jobcli_locators`
  COMMENT = 'UI Selectors , ATS Navigation , JobCLI Bot';

-- Table: jobcli_sync_versions (V95 | 89 rows)
ALTER TABLE `jobcli_sync_versions`
  COMMENT = 'Sync Versions , Rule Snapshots , JobCLI Bot';

-- Table: lead (V34 | 5063 rows)
ALTER TABLE `lead`
  COMMENT = 'Candidate Leads , Contact Info , Work Status';

-- Table: outreach_contacts (V28_1 | 2 rows)
ALTER TABLE `outreach_contacts`
  COMMENT = 'Outreach Contacts , Unsubscribe Lists , Bounce Tracking';

-- Table: potential_leads (V50 | 221 rows)
ALTER TABLE `potential_leads`
  COMMENT = 'Potential Leads , Sourced Profiles , Outreach Status';

-- Table: projects (V19 | 15 rows)
ALTER TABLE `projects`
  COMMENT = 'Company Projects , Task Timelines , Owner Tracking';

-- Table: recording (V91 | 6521 rows)
ALTER TABLE `recording`
  COMMENT = 'Session Recordings , Video Links , AI Prep Module';

-- Table: session (V122 | 3116 rows)
ALTER TABLE `session`
  COMMENT = 'Candidate Sessions , Login Tracking , Class Access';

-- Table: vendor (V9 | 6095 rows)
ALTER TABLE `vendor`
  COMMENT = 'Recruiter Contacts , Vendor Directory , Email Sourcing';

-- Table: vendor_contact_extracts (V49 | 4454 rows)
ALTER TABLE `vendor_contact_extracts`
  COMMENT = 'Extracted Contacts , Daily Sourcing , Vendor Pipeline';

-- Table: wboxcli_apply_analytics (V113 | 9 rows)
ALTER TABLE `wboxcli_apply_analytics`
  COMMENT = 'CLI Apply Stats , Job Apply Runs , Automation Analytics';

-- =============================================================================
-- SECTION 2: Tables NOT in migration chain (safe conditional via procedure)
--            No-op in CI/CD; applied on production/local wbl where table exists.
-- =============================================================================

DELIMITER 

DROP PROCEDURE IF EXISTS add_tbl_comment

CREATE PROCEDURE add_tbl_comment(IN p_table VARCHAR(128), IN p_comment VARCHAR(512))
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = p_table
  ) THEN
    SET @q = CONCAT('ALTER TABLE `', p_table, '` COMMENT = ''', p_comment, '''');
    PREPARE s FROM @q;
    EXECUTE s;
    DEALLOCATE PREPARE s;
  END IF;
END

DELIMITER ;

-- Tables with data that exist only outside the Flyway migration chain:
CALL add_tbl_comment('encrypted_configs',          'App Settings , Encrypted Keys , System Security');
CALL add_tbl_comment('extension_keys',             'Extension Keys , Device Tokens , Chrome Bot Auth');
CALL add_tbl_comment('flyway_schema_history',      'Flyway History , Migration Scripts , Version Tracking');
CALL add_tbl_comment('internal_documents',         'Internal Docs , Training Guides , Reference Links');
CALL add_tbl_comment('job_activity_log',           'Job Logs , Daily Submissions , Application Tracking');
CALL add_tbl_comment('linkedin_only_contact',      'LinkedIn Contacts , Recruiter Profiles , Vendor Sourcing');
CALL add_tbl_comment('outreach_email_recipients',  'Email Recipients , Delivery Targets , Outreach Campaigns');
CALL add_tbl_comment('outreach_emails',            'Outreach Emails , Recruiter Directory , Delivery Status');
CALL add_tbl_comment('personal_domain_contact',    'Vendor Contacts , Personal Domains , Recruiter Directory');
CALL add_tbl_comment('placement_fee_collection',   'Placement Fees , Installment Dates , Payment Tracking');
CALL add_tbl_comment('recording_batch',            'Batch Recordings , Group Sessions , AI Prep Module');
CALL add_tbl_comment('schema_migrations',          'Schema Versions , Rails Migrations , DB History');
CALL add_tbl_comment('submission_events',          'Submission Events , Application Actions , Tracking Log');
CALL add_tbl_comment('submissions',                'Job Submissions , Application Records , ATS Tracking');
CALL add_tbl_comment('submitters',                 'Submitters Info , Contact Details , Application Source');
CALL add_tbl_comment('talentscreen_apply_queue',   'Apply Queue , Talentscreen Jobs , Automation Pipeline');
CALL add_tbl_comment('template_folders',           'Email Folders , Template Groups , Outreach Org');
CALL add_tbl_comment('templates',                  'Email Templates , Outreach Drafts , Campaign Content');
CALL add_tbl_comment('users',                      'System Users , Auth Accounts , Role Management');
CALL add_tbl_comment('xxx_candidate_old',          'Archived Candidates , Legacy Data , Pre-Migration Records');

DROP PROCEDURE IF EXISTS add_tbl_comment;

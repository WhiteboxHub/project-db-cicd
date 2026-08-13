-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to projects)
-- =============================================================================
-- Purpose  : Short, clean, 3-point structured comments for all active tables
--            containing data between encrypted_configs and projects.
-- Verified : Audited directly against database dump (Dump20260811.sql).
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

-- Table: encrypted_configs (3 rows in dump)
ALTER TABLE `encrypted_configs`
  COMMENT = 'App Settings , Encrypted Keys , System Security';

-- Table: event_logs (175 rows in dump)
ALTER TABLE `event_logs`
  COMMENT = 'Event Logs , Cleanup History , Database Automation';

-- Table: extension_keys (4 rows in dump)
ALTER TABLE `extension_keys`
  COMMENT = 'Extension Keys , Device Tokens , Chrome Bot Auth';

-- Table: flyway_schema_history (124 rows in dump)
ALTER TABLE `flyway_schema_history`
  COMMENT = 'Flyway History , Migration Scripts , Version Tracking';

-- Table: internal_documents (24 rows in dump)
ALTER TABLE `internal_documents`
  COMMENT = 'Internal Docs , Training Guides , Reference Links';

-- Table: job_activity_log (644 rows in dump)
ALTER TABLE `job_activity_log`
  COMMENT = 'Job Logs , Daily Submissions , Application Tracking';

-- Table: job_automation_keywords (103 rows in dump)
ALTER TABLE `job_automation_keywords`
  COMMENT = 'Domain Filters , Keyword Rules , Email Extractor';

-- Table: job_link_clicks (5,372 rows in dump)
ALTER TABLE `job_link_clicks`
  COMMENT = 'Job Clicks , Candidate Views , Usage Analytics';

-- Table: job_listing (1,782 rows in dump)
ALTER TABLE `job_listing`
  COMMENT = 'Job Postings , Sourced Boards , Application Links';

-- Table: job_types (27 rows in dump)
ALTER TABLE `job_types`
  COMMENT = 'Job Categories , Manual & Bot Tasks , Owner Mapping';

-- Table: jobcli_field_answers (118 rows in dump)
ALTER TABLE `jobcli_field_answers`
  COMMENT = 'Field Answers , Form Auto-Fill , JobCLI Bot';

-- Table: jobcli_locators (6 rows in dump)
ALTER TABLE `jobcli_locators`
  COMMENT = 'UI Selectors , ATS Navigation , JobCLI Bot';

-- Table: jobcli_sync_versions (89 rows in dump)
ALTER TABLE `jobcli_sync_versions`
  COMMENT = 'Sync Versions , Rule Snapshots , JobCLI Bot';

-- Table: lead (5,063 rows in dump)
ALTER TABLE `lead`
  COMMENT = 'Candidate Leads , Contact Info , Work Status';

-- Table: linkedin_only_contact (734 rows in dump)
ALTER TABLE `linkedin_only_contact`
  COMMENT = 'LinkedIn Contacts , Recruiter Profiles , Vendor Sourcing';

-- Table: outreach_contacts (2 rows in dump)
ALTER TABLE `outreach_contacts`
  COMMENT = 'Outreach Contacts , Unsubscribe Lists , Bounce Tracking';

-- Table: outreach_emails (12,123 rows in dump)
ALTER TABLE `outreach_emails`
  COMMENT = 'Outreach Emails , Recruiter Directory , Delivery Status';

-- Table: personal_domain_contact (7,494 rows in dump)
ALTER TABLE `personal_domain_contact`
  COMMENT = 'Vendor Contacts , Personal Domains , Recruiter Directory';

-- Table: placement_fee_collection (96 rows in dump)
ALTER TABLE `placement_fee_collection`
  COMMENT = 'Placement Fees , Installment Dates , Payment Tracking';

-- Table: potential_leads (221 rows in dump)
ALTER TABLE `potential_leads`
  COMMENT = 'Potential Leads , Sourced Profiles , Outreach Status';

-- Table: projects (15 rows in dump)
ALTER TABLE `projects`
  COMMENT = 'Company Projects , Task Timelines , Owner Tracking';

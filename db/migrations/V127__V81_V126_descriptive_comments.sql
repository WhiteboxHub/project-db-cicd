-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to xxx_candidate_old)
-- =============================================================================
-- Purpose  : Add short, clean 3-point structured comments for all active tables
--            from encrypted_configs to xxx_candidate_old in alphabetical order.
-- Verified : Audited against database dump (Dump20260811.sql).
--            Only tables populated with active data are included.
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

-- Table: outreach_email_recipients (113,512 rows in dump)
ALTER TABLE `outreach_email_recipients`
  COMMENT = 'Email Recipients , Delivery Targets , Outreach Campaigns';

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

-- Table: recording (6,521 rows in dump)
ALTER TABLE `recording`
  COMMENT = 'Session Recordings , Video Links , AI Prep Module';

-- Table: recording_batch (11,962 rows in dump)
ALTER TABLE `recording_batch`
  COMMENT = 'Batch Recordings , Group Sessions , AI Prep Module';

-- Table: schema_migrations (37 rows in dump)
ALTER TABLE `schema_migrations`
  COMMENT = 'Schema Versions , Rails Migrations , DB History';

-- Table: session (3,116 rows in dump)
ALTER TABLE `session`
  COMMENT = 'Candidate Sessions , Login Tracking , Class Access';

-- Table: subject (77 rows in dump)
ALTER TABLE `subject`
  COMMENT = 'Training Subjects , Course Topics , Curriculum Modules';

-- Table: submission_events (2 rows in dump)
ALTER TABLE `submission_events`
  COMMENT = 'Submission Events , Application Actions , Tracking Log';

-- Table: submissions (2 rows in dump)
ALTER TABLE `submissions`
  COMMENT = 'Job Submissions , Application Records , ATS Tracking';

-- Table: submitters (2 rows in dump)
ALTER TABLE `submitters`
  COMMENT = 'Submitters Info , Contact Details , Application Source';

-- Table: talentscreen_apply_queue (10 rows in dump)
ALTER TABLE `talentscreen_apply_queue`
  COMMENT = 'Apply Queue , Talentscreen Jobs , Automation Pipeline';

-- Table: template_folders (1 row in dump)
ALTER TABLE `template_folders`
  COMMENT = 'Email Folders , Template Groups , Outreach Org';

-- Table: templates (9 rows in dump)
ALTER TABLE `templates`
  COMMENT = 'Email Templates , Outreach Drafts , Campaign Content';

-- Table: users (1 row in dump)
ALTER TABLE `users`
  COMMENT = 'System Users , Auth Accounts , Role Management';

-- Table: vendor (6,095 rows in dump)
ALTER TABLE `vendor`
  COMMENT = 'Recruiter Contacts , Vendor Directory , Email Sourcing';

-- Table: vendor_contact_extracts (4,454 rows in dump)
ALTER TABLE `vendor_contact_extracts`
  COMMENT = 'Extracted Contacts , Daily Sourcing , Vendor Pipeline';

-- Table: wboxcli_apply_analytics (9 rows in dump)
ALTER TABLE `wboxcli_apply_analytics`
  COMMENT = 'CLI Apply Stats , Job Apply Runs , Automation Analytics';

-- Table: xxx_candidate_old (1,194 rows in dump)
ALTER TABLE `xxx_candidate_old`
  COMMENT = 'Archived Candidates , Legacy Data , Pre-Migration Records';

-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to xxx_candidate_old)
-- =============================================================================
-- Purpose  : Short, clean, 3-point structured comments for tables that:
--            (1) exist in the migration chain (V1-V126), AND
--            (2) contain active data in the database dump.
-- Verified : Audited against Dump20260811.sql and Flyway migration chain V1-V126.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
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

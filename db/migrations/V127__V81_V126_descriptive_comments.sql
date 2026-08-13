-- =============================================================================
-- Migration V127: Descriptive Table Comments (Scope: encrypted_configs to projects)
-- =============================================================================
-- Purpose  : Short, clean, 3-point structured comments for tables that exist
--            in the migration chain (V1-V126) between encrypted_configs to projects.
-- Verified : Audited against dump (Dump20260811.sql) and migration file chain.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

-- Table: event_logs (Created in V56 | 175 rows in dump)
ALTER TABLE `event_logs`
  COMMENT = 'Event Logs , Cleanup History , Database Automation';

-- Table: job_automation_keywords (Created in V6 | 103 rows in dump)
ALTER TABLE `job_automation_keywords`
  COMMENT = 'Domain Filters , Keyword Rules , Email Extractor';

-- Table: job_link_clicks (Created in V80 | 5372 rows in dump)
ALTER TABLE `job_link_clicks`
  COMMENT = 'Job Clicks , Candidate Views , Usage Analytics';

-- Table: job_listing (Created in V82 | 1782 rows in dump)
ALTER TABLE `job_listing`
  COMMENT = 'Job Postings , Sourced Boards , Application Links';

-- Table: job_types (Created in V3_1 | 27 rows in dump)
ALTER TABLE `job_types`
  COMMENT = 'Job Categories , Manual and Bot Tasks , Owner Mapping';

-- Table: jobcli_field_answers (Created in V95 | 118 rows in dump)
ALTER TABLE `jobcli_field_answers`
  COMMENT = 'Field Answers , Form Auto-Fill , JobCLI Bot';

-- Table: jobcli_locators (Created in V95 | 6 rows in dump)
ALTER TABLE `jobcli_locators`
  COMMENT = 'UI Selectors , ATS Navigation , JobCLI Bot';

-- Table: jobcli_sync_versions (Created in V95 | 89 rows in dump)
ALTER TABLE `jobcli_sync_versions`
  COMMENT = 'Sync Versions , Rule Snapshots , JobCLI Bot';

-- Table: lead (Created in V34 | 5063 rows in dump)
ALTER TABLE `lead`
  COMMENT = 'Candidate Leads , Contact Info , Work Status';

-- Table: outreach_contacts (Created in V28_1 | 2 rows in dump)
ALTER TABLE `outreach_contacts`
  COMMENT = 'Outreach Contacts , Unsubscribe Lists , Bounce Tracking';

-- Table: potential_leads (Created in V50 | 221 rows in dump)
ALTER TABLE `potential_leads`
  COMMENT = 'Potential Leads , Sourced Profiles , Outreach Status';

-- Table: projects (Created in V19 | 15 rows in dump)
ALTER TABLE `projects`
  COMMENT = 'Company Projects , Task Timelines , Owner Tracking';

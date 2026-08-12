-- =============================================================================
-- Migration V127: Descriptive Table Comments (V81 to V126 CREATE TABLE scope)
-- =============================================================================
-- Purpose  : Add multi-point structured comments (3-4 concise points per table)
--            covering Entity, Data Content, Functional Module, and Status.
-- Note     : ALTER TABLE ... COMMENT is metadata-only. Zero impact on data/columns.
-- =============================================================================

-- V81 | EVENT only - no table created (cleanup_old_job_listings event on job_listing)

-- V82 | V82__job_listing_schemas.sql
ALTER TABLE `job_listing`
  COMMENT = 'Job Listings , Sources: LinkedIn & Web , Used for Candidate Applications , Daily Auto-Clean';

-- V91 | V91__create_coderpad_tables.sql
ALTER TABLE `code_snippet`
  COMMENT = 'CoderPad Snippets , Technical Coding Tests , Starter Code & Templates , Interview Prep Tool';

ALTER TABLE `code_execution_log`
  COMMENT = 'CoderPad Logs , Test Run Output , Error & Execution Tracking , Candidate Coding Sessions';

ALTER TABLE `coderpad_question`
  COMMENT = 'Interview Questions , Problem Statements , Test Cases & Solutions , Technical Assessments';

-- V95 | V95__create_jobcli_sync_tables.sql
ALTER TABLE `jobcli_field_answers`
  COMMENT = 'JobCLI Field Answers , Saved Candidate Data , Auto-Fill Form Inputs , Job Application Bot';

ALTER TABLE `jobcli_locators`
  COMMENT = 'JobCLI Locators , Web UI Selectors (CSS/XPath) , Job Board Navigation , Form Automation Bot';

ALTER TABLE `jobcli_sync_versions`
  COMMENT = 'JobCLI Sync Versions , Form Rule Snapshots , Version History , Application Bot Config';

-- V96 | V96__creating_new_tables.sql
ALTER TABLE `candidate_resume`
  COMMENT = 'Candidate Resumes , JSON Formatted Data , Profile Parsing , Resume Analysis & Matching';

-- V107 | V107__create_candidate_llm_api_keys.sql
ALTER TABLE `candidate_llm_api_keys`
  COMMENT = 'Candidate LLM Keys , OpenAI & Claude Credentials , Key Validation & Status , AI Prep Interview Tool';

-- V108 | V108__create_campaign_emails.sql
ALTER TABLE `automation_workflows_schedule`
  COMMENT = 'Workflow Schedules , Outreach Automation , Execution Timers , Candidate Email Campaigns';

ALTER TABLE `campaign_emails`
  COMMENT = 'Campaign Emails , Marketing Outreach Logs , Delivery & Send Status , Candidate Email Pipeline';

-- V113 | V113__wboxcli_apply_analytics_tables.sql
ALTER TABLE `cli_usage_events`
  COMMENT = 'CLI Usage Events , Command Execution Logs , Telemetry Tracking , WboxCLI Apply Tool';

ALTER TABLE `wboxcli_apply_analytics`
  COMMENT = 'Apply Analytics , Job Submission Metrics , Success & Failure Rates , WboxCLI Automation Tool';

-- V115 | V115__create_application_report.sql
ALTER TABLE `application_report`
  COMMENT = 'Application Reports , Candidate Activity Tracking , Submission Summaries , Pipeline Reporting';

-- V118 | V118__create_video_url_column_in_AI_prep_evaluation_table.sql
ALTER TABLE `aiprep_tool_evaluations`
  COMMENT = 'AI Mock Evaluations , Candidate Test Scores , Feedback & Video Links , AI Prep Interview Tool';

-- V122 | V122__new_tables_candidate_classes_and_candidate_session.sql
ALTER TABLE `recording`
  COMMENT = 'Class Recordings , Training Lecture Videos , Video & Backup URLs , Candidate Portal Playback';

ALTER TABLE `session`
  COMMENT = 'Live Sessions , Training Class Schedules , Meeting Links & Subjects , Candidate Portal Calendar';

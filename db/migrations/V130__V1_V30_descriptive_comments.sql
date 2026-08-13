-- ==============================================================================
-- Flyway Migration V130: Add Table Comments (Tables 1 to 30)
-- Target: High-quality functional documentation for active production tables
-- ==============================================================================

ALTER TABLE aiprep_tool_attempts 
COMMENT = 'Stores candidate mock interview attempt counters partitioned by category to monitor platform usage.';

ALTER TABLE aiprep_tool_candidates 
COMMENT = 'Stores AI Prep candidate accounts, login credentials, encrypted LLM API keys, and session activity.';

ALTER TABLE aiprep_tool_case_studies 
COMMENT = 'Stores technical case studies, interview scenarios, and questions assigned during AI Prep sessions.';

ALTER TABLE aiprep_tool_coderpad_cache 
COMMENT = 'Caches candidate Coderpad performance metrics, including solved questions, submission counts, pass rates, and languages used.';

ALTER TABLE aiprep_tool_project_context 
COMMENT = 'Stores candidate project architecture, tech stack, and background details used to personalize AI interviews.';

ALTER TABLE aiprep_tool_resumes 
COMMENT = 'Stores candidate parsed resume JSON data and resume PDF URLs for AI interview personalization.';

ALTER TABLE automation_contact_extracts 
COMMENT = 'Stores staging recruiter and vendor contacts extracted from automated email digests before deduplication.';

ALTER TABLE automation_workflows 
COMMENT = 'Stores background automation workflow definitions, configurations, handler classes, and active status.';

ALTER TABLE batch 
COMMENT = 'Stores training cohort batches, assigned instructors, curriculum mappings, and start/end dates.';

ALTER TABLE candidate 
COMMENT = 'Stores candidate master profiles including contact details, visa status, skills, and onboarding stage.';

ALTER TABLE candidate_classes 
COMMENT = 'Stores candidate training class enrollments, attendance, grades, and completion records.';

ALTER TABLE candidate_interview 
COMMENT = 'Stores candidate interview schedules, company details, round types, interviewer notes, and audio links.';

ALTER TABLE candidate_llm_api_keys 
COMMENT = 'Stores candidate encrypted LLM provider API keys (OpenAI, Claude, Gemini) and validation statuses.';

ALTER TABLE company_hr_contacts 
COMMENT = 'Stores contact details, company names, and locations of corporate HR professionals and recruiters, indicating immigration team status.';

ALTER TABLE employee 
COMMENT = 'Stores internal employee and instructor profiles, including contact details, employment status, roles, and identification numbers.';

ALTER TABLE employee_task 
COMMENT = 'Stores internal employee task assignments, tracking due dates, priority levels, notes, and execution statuses.';

ALTER TABLE job_automation_keywords 
COMMENT = 'Stores filtering rules, match types, actions, and priority settings used by background automation engines to filter emails or job data.';

ALTER TABLE job_types 
COMMENT = 'Stores job classifications, unique identifiers, tracking owners, and operational categories (manual or automated).';

ALTER TABLE projects 
COMMENT = 'Stores internal project details, capturing project owners, schedule timelines, priority levels, and execution statuses.';

ALTER TABLE vendor 
COMMENT = 'Stores master profiles for recruitment vendors, sourcers, and partners, tracking contact data, location, and onboarding statuses.';

ALTER TABLE vendor_contact_extracts 
COMMENT = 'Stores parsed recruiter and vendor contact records extracted from automated job and email feeds before promotion to vendors.';

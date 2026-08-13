-- ==============================================================================
-- Flyway Migration V130: Add Table Comments (Tables 1 to 30)
-- Target: High-quality functional documentation for active production tables
-- ==============================================================================

ALTER TABLE automation_workflows 
COMMENT = 'Stores background automation workflow definitions, configurations, handler classes, and active status.';

ALTER TABLE candidate 
COMMENT = 'Stores candidate master profiles including contact details, visa status, skills, and onboarding stage.';

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

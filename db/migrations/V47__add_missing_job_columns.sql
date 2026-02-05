-- Add email_engine_id to job_definition
ALTER TABLE job_definition
ADD COLUMN email_engine_id INT NULL
AFTER candidate_marketing_id;

-- Add manually_triggered to job_schedule
ALTER TABLE job_schedule
ADD COLUMN manually_triggered BOOLEAN NOT NULL DEFAULT FALSE
AFTER enabled;

-- Add Job Description and Position Title to Candidate Interview table
ALTER TABLE candidate_interview 
ADD COLUMN job_description TEXT NULL,
ADD COLUMN position_title VARCHAR(255) NULL;

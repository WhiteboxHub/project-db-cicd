-- Add job_url_type column to job_listing table
ALTER TABLE `job_listing`
ADD COLUMN `job_url_type` VARCHAR(50) DEFAULT NULL AFTER `job_url`;

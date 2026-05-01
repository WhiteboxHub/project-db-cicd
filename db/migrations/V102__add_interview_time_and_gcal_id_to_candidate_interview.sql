-- Add interview_time and gcal_event_id columns to candidate_interview table
ALTER TABLE `candidate_interview`
ADD COLUMN `interview_time` TIME NULL AFTER `interview_date`,
ADD COLUMN `gcal_event_id` VARCHAR(255) NULL;

-- Add duration_minutes column to candidate_interview table
ALTER TABLE `candidate_interview`
ADD COLUMN `duration_minutes` INT DEFAULT 60;

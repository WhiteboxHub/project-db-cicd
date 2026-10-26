-- =====================================================================
-- Flyway Migration V160: Standardize Hiring Manager Question Time Limits by Difficulty
--
-- Updates time_limit_seconds for all HIRING_MANAGER questions in ai_prep_question_bank
-- to align with the standard difficulty timing matrix:
--   - EASY: 60 seconds
--   - MEDIUM: 90 seconds (including default/unassigned difficulty)
--   - HARD: 150 seconds
-- =====================================================================

UPDATE `ai_prep_question_bank`
SET `time_limit_seconds` = 60
WHERE `category` = 'HIRING_MANAGER'
  AND `difficulty_level` = 'EASY';

UPDATE `ai_prep_question_bank`
SET `time_limit_seconds` = 90
WHERE `category` = 'HIRING_MANAGER'
  AND (`difficulty_level` = 'MEDIUM' OR `difficulty_level` IS NULL);

UPDATE `ai_prep_question_bank`
SET `time_limit_seconds` = 150
WHERE `category` = 'HIRING_MANAGER'
  AND `difficulty_level` = 'HARD';

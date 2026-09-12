-- Flyway Migration V136: Add persistent assessment_uuid column for AI Prep Assessment
ALTER TABLE `ai_prep_assessment`
    ADD COLUMN `assessment_uuid` VARCHAR(64) NULL AFTER `id`;

-- Backfill existing rows with UUID if any exist
UPDATE `ai_prep_assessment` 
SET `assessment_uuid` = UUID() 
WHERE `assessment_uuid` IS NULL;

ALTER TABLE `ai_prep_assessment`
    MODIFY COLUMN `assessment_uuid` VARCHAR(64) NOT NULL,
    ADD UNIQUE INDEX `uq_assessment_uuid` (`assessment_uuid`);

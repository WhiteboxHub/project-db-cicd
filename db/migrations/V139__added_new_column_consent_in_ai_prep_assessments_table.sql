-- Flyway Migration V139: Add <column_name> JSON column to ai_prep_assessment
ALTER TABLE `ai_prep_assessment`
    ADD COLUMN `consent` JSON NULL AFTER `youtube_url`;
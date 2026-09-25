-- Flyway Migration V137: Add CANCELLED to ai_prep_assessment status enum
ALTER TABLE `ai_prep_assessment`
    MODIFY COLUMN `status` ENUM(
        'IN_PROGRESS',
        'EVALUATING',
        'COMPLETED',
        'FAILED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'IN_PROGRESS';

ALTER TABLE `ai_prep_assessment`
    ADD COLUMN `cancelled_at` DATETIME NULL AFTER `completed_at`;

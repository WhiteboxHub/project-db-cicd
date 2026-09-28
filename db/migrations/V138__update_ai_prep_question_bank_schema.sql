-- =====================================================================
-- Flyway Migration V138: Update ai_prep_question_bank taxonomy and schema
-- - Drops old sub_category check constraint and index
-- - Adds subject, scope, time_limit_seconds, and ground_truth columns
-- - Renames sub_category to concept and standardizes ENUM values
-- - Updates difficulty_level to 3 tiers (EASY, MEDIUM, HARD)
-- - Adds composite indexes for query optimization
-- =====================================================================

-- 1. Drop old constraint and index referencing sub_category
ALTER TABLE `ai_prep_question_bank`
    DROP CHECK `chk_qb_subcategory`;

ALTER TABLE `ai_prep_question_bank`
    DROP INDEX `idx_qb_category_subcategory`;

-- 2. Add subject column (NULLable for INTRO/JD_INTRO compatibility)
ALTER TABLE `ai_prep_question_bank`
    ADD COLUMN `subject` ENUM(
        'AI Engineering',
        'Software Engineering',
        'DevOps and Cloud'
    ) NULL AFTER `category`;

-- 3. Rename sub_category to concept and convert to standardized 18-concept ENUM
ALTER TABLE `ai_prep_question_bank`
    CHANGE COLUMN `sub_category` `concept` ENUM(
        'Python & Data Manipulation',
        'ML & Deep Learning Fundamentals',
        'ML Frameworks & Tooling',
        'NLP',
        'Generative AI & LLMs',
        'RAG & Retrieval',
        'Agentic AI & Multi-Agent Systems',
        'Models & Context Engineering',
        'AI Systems Ops: Evaluation, Guardrails & Observability',
        'System Architecture & Design',
        'API Design & Microservices',
        'Databases & Caching',
        'Concurrency & Async Systems',
        'Data Structures & Algorithms',
        'Containers & Orchestration',
        'CI/CD & GitOps',
        'Cloud Architecture & Services',
        'Infrastructure as Code & Security'
    ) NULL;

-- 4. Update any existing EXPERT rows to HARD before modifying ENUM
UPDATE `ai_prep_question_bank`
SET `difficulty_level` = 'HARD'
WHERE `difficulty_level` = 'EXPERT';

-- 5. Modify difficulty_level to 3 tiers (EASY, MEDIUM, HARD) and make NULLable
ALTER TABLE `ai_prep_question_bank`
    MODIFY COLUMN `difficulty_level` ENUM('EASY', 'MEDIUM', 'HARD') NULL DEFAULT 'MEDIUM';

-- 6. Add scope (NULLable) and time_limit_seconds
ALTER TABLE `ai_prep_question_bank`
    ADD COLUMN `scope` ENUM('BROAD', 'SPECIFIC') NULL DEFAULT 'SPECIFIC' AFTER `difficulty_level`,
    ADD COLUMN `time_limit_seconds` INT NOT NULL DEFAULT 120 AFTER `scope`;

-- 7. Add ground_truth JSON column after question_text
ALTER TABLE `ai_prep_question_bank`
    ADD COLUMN `ground_truth` JSON NULL AFTER `question_text`;

-- 8. Add updated composite indexes for query performance
ALTER TABLE `ai_prep_question_bank`
    ADD INDEX `idx_qb_category_concept` (`category`, `concept`),
    ADD INDEX `idx_qb_subject_concept` (`subject`, `concept`);
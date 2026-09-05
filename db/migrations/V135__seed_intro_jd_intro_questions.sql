-- =====================================================================
-- Flyway Migration V135: Seed INTRO and JD_INTRO Questions
-- Target Table: ai_prep_question_bank
-- =====================================================================

INSERT INTO `ai_prep_question_bank`
    (`category`, `sub_category`, `difficulty_level`, `question_text`, `is_active`)
VALUES
    ('INTRO', NULL, 'EASY', 'Please introduce yourself and walk us through your background and experience.', 1),
    ('JD_INTRO', NULL, 'EASY', 'Please introduce yourself and walk us through your background and experience.', 1);

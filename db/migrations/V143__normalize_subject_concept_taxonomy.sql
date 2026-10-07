-- =====================================================================
-- Flyway Migration V143: Normalize Subject-Concept Taxonomy
--
-- Corrects subject-concept misalignments introduced in V140 and carried
-- forward in V141. Each concept is now strictly assigned to its canonical
-- subject per the standardized taxonomy:
--
--   AI Engineering:
--     Python & Data Manipulation, ML & Deep Learning Fundamentals,
--     ML Frameworks & Tooling, NLP, Generative AI & LLMs,
--     RAG & Retrieval, Agentic AI & Multi-Agent Systems,
--     Models & Context Engineering,
--     AI Systems Ops: Evaluation, Guardrails & Observability
--
--   Software Engineering:
--     System Architecture & Design, API Design & Microservices,
--     Databases & Caching, Concurrency & Async Systems,
--     Data Structures & Algorithms
--
--   DevOps and Cloud:
--     Containers & Orchestration, CI/CD & GitOps,
--     Cloud Architecture & Services, Infrastructure as Code & Security
--
-- Total affected rows:
--   V140 legacy (is_active = 0): 37 rows across 11 misaligned pairs
--   V141 active (is_active = 1): 10 rows across 1 misaligned pair
--
-- ROLLBACK / RECOVERY:
--   To revert, run the inverse UPDATE statements at the bottom of this
--   file (commented out in the ROLLBACK section).
-- =====================================================================

-- -----------------------------------------------------------------
-- 1. Fix concepts that belong to AI Engineering but are under wrong subjects
-- -----------------------------------------------------------------

-- 1a. 'AI Systems Ops: Evaluation, Guardrails & Observability' → AI Engineering
--     (was incorrectly under DevOps and Cloud: 9 rows, Software Engineering: 4 rows)
UPDATE `ai_prep_question_bank`
SET `subject` = 'AI Engineering'
WHERE `subject` = 'DevOps and Cloud'
  AND `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability';

UPDATE `ai_prep_question_bank`
SET `subject` = 'AI Engineering'
WHERE `subject` = 'Software Engineering'
  AND `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability';

-- 1b. 'Python & Data Manipulation' → AI Engineering
--     (was incorrectly under Software Engineering: 9 in V140 + 10 in V141, DevOps and Cloud: 4 in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'AI Engineering'
WHERE `subject` = 'Software Engineering'
  AND `concept` = 'Python & Data Manipulation';

UPDATE `ai_prep_question_bank`
SET `subject` = 'AI Engineering'
WHERE `subject` = 'DevOps and Cloud'
  AND `concept` = 'Python & Data Manipulation';

-- 1c. 'RAG & Retrieval' → AI Engineering
--     (was incorrectly under Software Engineering: 2 rows in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'AI Engineering'
WHERE `subject` = 'Software Engineering'
  AND `concept` = 'RAG & Retrieval';

-- -----------------------------------------------------------------
-- 2. Fix concepts that belong to Software Engineering but are under wrong subjects
-- -----------------------------------------------------------------

-- 2a. 'API Design & Microservices' → Software Engineering
--     (was incorrectly under AI Engineering: 1 row in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'Software Engineering'
WHERE `subject` = 'AI Engineering'
  AND `concept` = 'API Design & Microservices';

-- 2b. 'System Architecture & Design' → Software Engineering
--     (was incorrectly under AI Engineering: 2 rows, DevOps and Cloud: 1 row in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'Software Engineering'
WHERE `subject` = 'AI Engineering'
  AND `concept` = 'System Architecture & Design';

UPDATE `ai_prep_question_bank`
SET `subject` = 'Software Engineering'
WHERE `subject` = 'DevOps and Cloud'
  AND `concept` = 'System Architecture & Design';

-- -----------------------------------------------------------------
-- 3. Fix concepts that belong to DevOps and Cloud but are under wrong subjects
-- -----------------------------------------------------------------

-- 3a. 'CI/CD & GitOps' → DevOps and Cloud
--     (was incorrectly under AI Engineering: 1 row, Software Engineering: 3 rows in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'DevOps and Cloud'
WHERE `subject` = 'AI Engineering'
  AND `concept` = 'CI/CD & GitOps';

UPDATE `ai_prep_question_bank`
SET `subject` = 'DevOps and Cloud'
WHERE `subject` = 'Software Engineering'
  AND `concept` = 'CI/CD & GitOps';

-- 3b. 'Cloud Architecture & Services' → DevOps and Cloud
--     (was incorrectly under AI Engineering: 1 row in V140)
UPDATE `ai_prep_question_bank`
SET `subject` = 'DevOps and Cloud'
WHERE `subject` = 'AI Engineering'
  AND `concept` = 'Cloud Architecture & Services';


-- =====================================================================
-- ROLLBACK SECTION (Uncomment to revert)
-- =====================================================================
-- -- Revert AI Systems Ops back to DevOps and Cloud / Software Engineering
-- UPDATE `ai_prep_question_bank` SET `subject` = 'DevOps and Cloud' WHERE `subject` = 'AI Engineering' AND `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability' AND `is_active` = 0;
-- UPDATE `ai_prep_question_bank` SET `subject` = 'Software Engineering' WHERE `subject` = 'AI Engineering' AND `concept` = 'AI Systems Ops: Evaluation, Guardrails & Observability' AND `is_active` = 0;
--
-- -- Revert Python & Data Manipulation back to Software Engineering / DevOps and Cloud
-- UPDATE `ai_prep_question_bank` SET `subject` = 'Software Engineering' WHERE `subject` = 'AI Engineering' AND `concept` = 'Python & Data Manipulation';
-- UPDATE `ai_prep_question_bank` SET `subject` = 'DevOps and Cloud' WHERE `subject` = 'AI Engineering' AND `concept` = 'Python & Data Manipulation' AND `is_active` = 0;
--
-- -- Revert RAG & Retrieval back to Software Engineering
-- UPDATE `ai_prep_question_bank` SET `subject` = 'Software Engineering' WHERE `subject` = 'AI Engineering' AND `concept` = 'RAG & Retrieval' AND `is_active` = 0;
--
-- -- Revert API Design & Microservices back to AI Engineering
-- UPDATE `ai_prep_question_bank` SET `subject` = 'AI Engineering' WHERE `subject` = 'Software Engineering' AND `concept` = 'API Design & Microservices' AND `is_active` = 0;
--
-- -- Revert System Architecture & Design back to AI Engineering / DevOps and Cloud
-- UPDATE `ai_prep_question_bank` SET `subject` = 'AI Engineering' WHERE `subject` = 'Software Engineering' AND `concept` = 'System Architecture & Design' AND `is_active` = 0;
-- UPDATE `ai_prep_question_bank` SET `subject` = 'DevOps and Cloud' WHERE `subject` = 'Software Engineering' AND `concept` = 'System Architecture & Design' AND `is_active` = 0;
--
-- -- Revert CI/CD & GitOps back to AI Engineering / Software Engineering
-- UPDATE `ai_prep_question_bank` SET `subject` = 'AI Engineering' WHERE `subject` = 'DevOps and Cloud' AND `concept` = 'CI/CD & GitOps' AND `is_active` = 0;
-- UPDATE `ai_prep_question_bank` SET `subject` = 'Software Engineering' WHERE `subject` = 'DevOps and Cloud' AND `concept` = 'CI/CD & GitOps' AND `is_active` = 0;
--
-- -- Revert Cloud Architecture & Services back to AI Engineering
-- UPDATE `ai_prep_question_bank` SET `subject` = 'AI Engineering' WHERE `subject` = 'DevOps and Cloud' AND `concept` = 'Cloud Architecture & Services' AND `is_active` = 0;

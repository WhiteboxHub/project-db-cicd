
-- Migration: Remove legacy `ats_platforms` and `account_configs` tables



-- Summary of Changes:
-- 1. Drop foreign key constraints referencing `ats_platforms` from dependent
--    tables (`site_selectors`, `job_sites`) 
-- 2. Drop `ats_platforms` — legacy table that stored Applicant Tracking
--    System (ATS) platform metadata. Confirmed unused (no references in
--    frontend/backend codebase; no dependent data impact).
-- 3. Drop `account_configs` — legacy table that stored account-level
--    key-value configuration. Confirmed unused (table empty; no
--    references in frontend/backend codebase).




-- Drop foreign key constraints
ALTER TABLE site_selectors DROP FOREIGN KEY fk_selector_platform;
ALTER TABLE job_sites DROP FOREIGN KEY fk_site_platform;

-- Drop legacy tables
DROP TABLE IF EXISTS ats_platforms;
DROP TABLE IF EXISTS account_configs;
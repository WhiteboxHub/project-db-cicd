ALTER TABLE IF NOT EXISTS candidate_marketing
ADD COLUMN run_raw_positions_workflow TINYINT(1) NOT NULL DEFAULT 0 AFTER linkedin_post;

ALTER TABLE candidate_marketing
ADD COLUMN IF NOT EXISTS mass_email TINYINT(1) NOT NULL DEFAULT 0
COMMENT '1 = allowed for mass email campaigns, 0 = not allowed';

ALTER TABLE candidate_marketing
ADD COLUMN IF NOT EXISTS candidate_intro LONGTEXT
COMMENT 'Large candidate introduction content for outreach emails';
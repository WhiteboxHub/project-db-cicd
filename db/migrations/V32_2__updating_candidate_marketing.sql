ALTER TABLE candidate_marketing
ADD COLUMN mass_email TINYINT(1) NOT NULL DEFAULT 0
COMMENT '1 = allowed for mass email campaigns, 0 = not allowed';

ALTER TABLE candidate_marketing
ADD COLUMN candidate_intro LONGTEXT
COMMENT 'Large candidate introduction content for outreach ema
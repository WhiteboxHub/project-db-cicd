ALTER TABLE candidate_marketing
ADD COLUMN linkedin_post tinyint(1) NOT NULL DEFAULT '0' AFTER candidate_json;

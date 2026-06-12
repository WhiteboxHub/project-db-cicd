ALTER TABLE `candidate_marketing`
  ADD COLUMN `total_outreach_count` INT NOT NULL DEFAULT 0,
  ADD COLUMN `daily_outreach_limit` INT NOT NULL DEFAULT 250,
  ADD COLUMN `max_outreach_limit`   INT NOT NULL DEFAULT 500,
  ADD COLUMN `fcount`               INT NOT NULL DEFAULT 0;

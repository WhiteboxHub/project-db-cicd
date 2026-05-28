ALTER TABLE `candidate_marketing`
ADD COLUMN `run_outreach_emails` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag to trigger weekly vendor outreach emails via Outreach service';

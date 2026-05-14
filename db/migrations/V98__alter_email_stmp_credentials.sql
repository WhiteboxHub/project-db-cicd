ALTER TABLE `email_smtp_credentials`
ADD COLUMN `current_day_sent` int NOT NULL DEFAULT '0',
ADD COLUMN `last_reset_date` date NOT NULL DEFAULT (curdate()),
ADD COLUMN `is_warming_up` tinyint(1) NOT NULL DEFAULT '0',
ADD COLUMN `warmup_started_at` datetime DEFAULT NULL,
ADD COLUMN `warmup_daily_limit` int DEFAULT '5',
ADD COLUMN `last_used_at` datetime DEFAULT NULL,
ADD COLUMN `is_healthy` tinyint(1) NOT NULL DEFAULT '1';

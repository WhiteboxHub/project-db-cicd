-- 1. Create the evaluations table if it does not exist (for CI/CD and clean databases)
CREATE TABLE IF NOT EXISTS `aiprep_tool_evaluations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `passed` tinyint(1) DEFAULT NULL,
  `feedback` json DEFAULT NULL,
  `raw_response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_eval_user` (`user_id`),
  KEY `idx_eval_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Add the video_url column
ALTER TABLE aiprep_tool_evaluations ADD COLUMN video_url VARCHAR(300) DEFAULT NULL;

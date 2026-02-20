-- Migration: V61__update_email_extraction_workflow_credentials_sql.sql
-- Description: Updates the credentials_list_sql for the email extraction automation workflow (id=2)
--              to join candidate and candidate_marketing tables and filter by run_email_extraction flag.


-- whitebox_learning.automation_workflows definition

CREATE TABLE IF NOT EXISTS `automation_workflows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_key` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `workflow_type` enum('email_sender','extractor','transformer','webhook','sync') NOT NULL,
  `owner_id` int DEFAULT NULL,
  `status` enum('draft','active','paused','inactive') NOT NULL DEFAULT 'draft',
  `email_template_id` bigint unsigned DEFAULT NULL,
  `delivery_engine_id` bigint unsigned DEFAULT NULL,
  `credentials_list_sql` longtext COMMENT 'SQL to fetch actor credentials',
  `recipient_list_sql` longtext COMMENT 'SQL to fetch target recipients',
  `parameters_config` json DEFAULT NULL COMMENT 'Static config for the job',
  `version` int unsigned NOT NULL DEFAULT '1',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `last_mod_user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_workflow_key` (`workflow_key`),
  KEY `fk_workflow_owner` (`owner_id`),
  KEY `fk_workflow_template` (`email_template_id`),
  KEY `fk_workflow_delivery_engine` (`delivery_engine_id`),
  KEY `idx_workflow_type` (`workflow_type`),
  KEY `idx_workflow_status` (`status`),
  CONSTRAINT `fk_workflow_delivery_engine` FOREIGN KEY (`delivery_engine_id`) REFERENCES `delivery_engines` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_workflow_owner` FOREIGN KEY (`owner_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_workflow_template` FOREIGN KEY (`email_template_id`) REFERENCES `email_templates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

UPDATE automation_workflows
SET credentials_list_sql = '
SELECT 
    c.id AS candidate_id,
    cm.email,
    cm.imap_password,
    c.full_name
FROM candidate c
JOIN candidate_marketing cm 
    ON c.id = cm.candidate_id
WHERE cm.run_email_extraction = 1;
'
WHERE id = 2;

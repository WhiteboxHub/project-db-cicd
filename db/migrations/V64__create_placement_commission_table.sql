CREATE TABLE `placement_commission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placement_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `lastmod_user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmod_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_placement_employee` (`placement_id`,`employee_id`),
  KEY `fk_commission_employee` (`employee_id`),
  KEY `fk_commission_lastmod_user` (`lastmod_user_id`),
  CONSTRAINT `fk_commission_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_commission_lastmod_user` FOREIGN KEY (`lastmod_user_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_commission_placement` FOREIGN KEY (`placement_id`) REFERENCES `candidate_placement` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
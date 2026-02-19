CREATE TABLE `placement_commission_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placement_commission_id` int NOT NULL,
  `installment_no` int NOT NULL,
  `installment_amount` decimal(10,2) NOT NULL,
  `scheduled_date` date NOT NULL,
  `payment_status` enum('Pending','Paid') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_installment` (`placement_commission_id`,`installment_no`),
  CONSTRAINT `fk_scheduler_commission` FOREIGN KEY (`placement_commission_id`) REFERENCES `placement_commission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
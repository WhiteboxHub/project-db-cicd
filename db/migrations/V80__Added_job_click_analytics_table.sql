
CREATE TABLE IF NOT EXISTS `job_link_clicks` (
  `id`                bigint NOT NULL AUTO_INCREMENT,
  `authuser_id`       int NOT NULL,
  `job_listing_id`    bigint DEFAULT NULL,
  `click_count`       int DEFAULT 1,
  `first_clicked_at`  datetime DEFAULT CURRENT_TIMESTAMP,
  `last_clicked_at`   datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_candidate_job` (`authuser_id`, `job_listing_id`),
  CONSTRAINT `fk_click_authuser` FOREIGN KEY (`authuser_id`) REFERENCES `authuser` (`id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `job_listing` DROP FOREIGN KEY `fk_job_listing_raw`;

ALTER TABLE `job_listing` DROP INDEX `fk_job_listing_raw`;

DROP TABLE IF EXISTS `raw_job_listings`;
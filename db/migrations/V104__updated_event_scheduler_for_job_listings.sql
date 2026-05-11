-- deletes all job listings older than 7 days
DROP EVENT IF EXISTS cleanup_old_job_listings;

CREATE EVENT cleanup_old_job_listings
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM job_listing
WHERE created_at < NOW() - INTERVAL 7 DAY;
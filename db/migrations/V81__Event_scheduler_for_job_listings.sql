-- Automatically delete job listings older than 7 days
CREATE EVENT IF NOT EXISTS cleanup_old_job_listings
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM job_listing
WHERE created_at < NOW() - INTERVAL 7 DAY;
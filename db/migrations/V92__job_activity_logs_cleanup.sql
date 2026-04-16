DROP EVENT IF EXISTS ev_cleanup_job_activity_log;

-- Recreate it to run daily
CREATE EVENT ev_cleanup_job_activity_log
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 10 MINUTE
DO
DELETE FROM job_activity_log
WHERE lastmod_date_time < NOW() - INTERVAL 7 DAY;

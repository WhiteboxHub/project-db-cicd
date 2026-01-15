-- Drop old cleanup event if any

DROP EVENT IF EXISTS ev_cleanup_job_activity_log;


-- Weekly cleanup event

CREATE EVENT ev_cleanup_job_activity_log
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
DELETE FROM job_activity_log
WHERE activity_date < CURDATE() - INTERVAL 7 DAY;

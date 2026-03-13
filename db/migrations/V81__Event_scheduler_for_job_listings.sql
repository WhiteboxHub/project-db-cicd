
/* Event to clean old job listings based on source */
/* This event scheduler deletes jobs from linkedin and hiring.cafe sources older than 7 days and other sources older than 30 days */
CREATE EVENT IF NOT EXISTS cleanup_old_job_listings
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM job_listing
WHERE
(
    source IN ('linkedin','hiring.cafe')
    AND created_at < NOW() - INTERVAL 7 DAY
)
OR
(
    source NOT IN ('linkedin','hiring.cafe')
    AND created_at < NOW() - INTERVAL 30 DAY
);


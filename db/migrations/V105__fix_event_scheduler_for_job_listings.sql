-- Fix: Recreate the cleanup event for job listings
-- Problem: V104 was missing ON COMPLETION PRESERVE and failed due to Safe Update Mode.
-- Solution: Added ON COMPLETION PRESERVE and SET SQL_SAFE_UPDATES = 0 inside the event.
-- deletes all job listings older than 7 days and takes date now instead of timestamp 

DROP EVENT IF EXISTS cleanup_old_job_listings;

CREATE EVENT cleanup_old_job_listings
ON SCHEDULE EVERY 1 DAY
STARTS (CURRENT_DATE + INTERVAL 1 DAY)
ON COMPLETION PRESERVE
ENABLE
DO
BEGIN
    -- Allow deletion without primary key in WHERE clause
    SET SQL_SAFE_UPDATES = 0;
    
    DELETE FROM job_listing
    WHERE DATE(created_at) < CURDATE() - INTERVAL 7 DAY;
    
    SET SQL_SAFE_UPDATES = 1;
END;

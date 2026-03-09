/*Trigger for checking recent 3 days logs*/
SELECT *
FROM automation_workflow_logs
WHERE created_at >= NOW() - INTERVAL 3 DAY
ORDER BY created_at DESC;

/*Event scheduler for deleting old logs*/
CREATE EVENT cleanup_old_workflow_logs
ON SCHEDULE EVERY 1 HOUR
DO
DELETE FROM automation_workflow_logs
WHERE created_at < NOW() - INTERVAL 3 DAY;
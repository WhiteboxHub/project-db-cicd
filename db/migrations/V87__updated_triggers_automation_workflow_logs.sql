-- Trigger to select jobs from last 7 days
SELECT *
FROM automation_workflow_logs
WHERE created_at >= NOW() - INTERVAL 7 DAY
ORDER BY created_at DESC;


-- Updated event scheduler to delete logs older than 7 days
ALTER EVENT cleanup_old_workflow_logs
ON SCHEDULE EVERY 1 HOUR
DO
DELETE FROM automation_workflow_logs
WHERE created_at < NOW() - INTERVAL 7 DAY; 


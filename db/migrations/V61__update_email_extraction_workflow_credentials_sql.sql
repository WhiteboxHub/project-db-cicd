-- Migration: V61__update_email_extraction_workflow_credentials_sql.sql
-- Description: Updates the credentials_list_sql for the email extraction automation workflow (id=2)
--              to join candidate and candidate_marketing tables and filter by run_email_extraction flag.

UPDATE automation_workflows
SET credentials_list_sql = '
SELECT 
    c.id AS candidate_id,
    cm.email,
    cm.imap_password,
    c.full_name
FROM candidate c
JOIN candidate_marketing cm 
    ON c.id = cm.candidate_id
WHERE cm.run_email_extraction = 1;
'
WHERE id = 2;

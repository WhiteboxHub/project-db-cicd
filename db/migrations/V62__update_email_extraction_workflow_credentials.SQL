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
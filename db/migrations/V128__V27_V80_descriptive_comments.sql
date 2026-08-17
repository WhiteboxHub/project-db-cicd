-- Add descriptions only to tables whose comments are currently empty.

ALTER TABLE `authuser`
COMMENT = 'Stores application user accounts, authentication details, roles, account status, and login information.';

ALTER TABLE `automation_workflow_logs`
COMMENT = 'Stores automation workflow execution history, status, parameters, processing totals, errors, and timestamps.';

ALTER TABLE `delivery_engines`
COMMENT = 'Stores email delivery engine configuration, sender details, rate limits, retry rules, and operational status.';

ALTER TABLE `email_smtp_credentials`
COMMENT = 'Stores SMTP account configuration and credentials used by application email delivery processes.';

ALTER TABLE `event_logs`
COMMENT = 'Stores scheduled database event execution results, including event name, affected row count, and execution time.';

ALTER TABLE `job_link_clicks`
COMMENT = 'Stores per-user job listing click activity, including click totals and first and most recent click timestamps.';

ALTER TABLE `outreach_contacts`
COMMENT = 'Stores recruiter and company contacts collected for candidate outreach and marketing activities.';

ALTER TABLE `potential_leads`
COMMENT = 'Stores potential leads identified for review, qualification, assignment, and conversion.';
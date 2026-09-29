-- V141: Production Cleanup of Junk & Invalid Outreach Emails
-- Purpose:
--   1. Sanitize parser-corrupted email addresses in outreach_emails (strip <>, trailing dots, trailing commas, and ":mailto artifacts)
--   2. Deactivate fatal hard bounces and unfixable malformed records in outreach_emails (set status = 'INVALID')
--   3. Deactivate confirmed dead mailboxes, expired domains, and hard bounces in outreach_email_recipients (set status = 'INVALID')

-- 1. Sanitize recoverable syntax errors in outreach_emails
UPDATE outreach_emails 
SET email = TRIM(TRAILING '.' FROM REPLACE(REPLACE(REPLACE(SUBSTRING_INDEX(email, '":', 1), '<', ''), '>', ''), ',', ''))
WHERE email LIKE '<%>' 
   OR email LIKE '%.' 
   OR email LIKE '%,' 
   OR email LIKE '%":%';

-- 2. Deactivate fatal hard bounces and invalid addresses in outreach_emails
UPDATE outreach_emails 
SET status = 'INVALID',
    updated_at = NOW()
WHERE bounce_type IN ('HARD', 'BLOCKED') 
   OR failure_type IN ('MAILBOX_INVALID', 'DOMAIN_INVALID')
   OR email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';

-- 3. Deactivate confirmed dead mailboxes, expired domains, and bounces in outreach_email_recipients (30,002 records)
UPDATE outreach_email_recipients 
SET status = 'INVALID',
    updated_at = NOW()
WHERE mailbox_invalid = 1 
   OR domain_invalid = 1 
   OR bounce_flag = 1 
   OR email_invalid = 1 
   OR unsubscribe_flag = 1;

INSERT INTO outreach_contacts (email, source_type)
SELECT DISTINCT email, 'company_hr_contacts'
FROM company_hr_contacts
WHERE email IS NOT NULL
ON DUPLICATE KEY UPDATE outreach_contacts.email = outreach_contacts.email;

INSERT INTO outreach_contacts (email, source_type)
SELECT DISTINCT email, 'vendor_contact_extracts'
FROM vendor_contact_extracts
WHERE email IS NOT NULL
ON DUPLICATE KEY UPDATE outreach_contacts.email = outreach_contacts.email;

INSERT INTO outreach_contacts (email, source_type)
SELECT DISTINCT email, 'vendor'
FROM vendor
WHERE email IS NOT NULL
ON DUPLICATE KEY UPDATE outreach_contacts.email = outreach_contacts.email;

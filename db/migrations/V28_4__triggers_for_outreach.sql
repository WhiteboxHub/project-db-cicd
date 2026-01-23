CREATE TRIGGER trg_hr_contacts_ai
AFTER INSERT ON company_hr_contacts
FOR EACH ROW
INSERT IGNORE INTO outreach_contacts (email, source_type, source_id)
VALUES (NEW.email, 'company_hr_contacts', NULL);


CREATE TRIGGER trg_daily_extract_ai
AFTER INSERT ON vendor_contact_extracts
FOR EACH ROW
INSERT IGNORE INTO outreach_contacts (email, source_type, source_id)
VALUES (NEW.email, 'vendor_contact_extracts', NULL);

CREATE TRIGGER trg_vendor_ai
AFTER INSERT ON vendor
FOR EACH ROW
INSERT IGNORE INTO outreach_contacts (email, source_type, source_id)
VALUES (NEW.email, 'vendor', NULL);




DROP TRIGGER IF EXISTS trg_hr_contacts_ai;
DROP TRIGGER IF EXISTS trg_daily_extract_ai;
DROP TRIGGER IF EXISTS trg_vendor_ai;


CREATE TRIGGER trg_hr_contacts_ai
AFTER INSERT ON company_hr_contacts
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL AND NEW.email <> '' THEN
    INSERT INTO outreach_contacts (email, source_type)
    VALUES (NEW.email, 'company_hr_contacts')
    ON DUPLICATE KEY UPDATE
      updated_at = CURRENT_TIMESTAMP;
  END IF;
END;

CREATE TRIGGER trg_daily_extract_ai
AFTER INSERT ON vendor_contact_extracts
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL AND NEW.email <> '' THEN
    INSERT INTO outreach_contacts (email, source_type)
    VALUES (NEW.email, 'vendor_contact_extracts')
    ON DUPLICATE KEY UPDATE
      updated_at = CURRENT_TIMESTAMP;
  END IF;
END;


CREATE TRIGGER trg_vendor_ai
AFTER INSERT ON vendor
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL AND NEW.email <> '' THEN
    INSERT INTO outreach_contacts (email, source_type)
    VALUES (NEW.email, 'vendor')
    ON DUPLICATE KEY UPDATE
      updated_at = CURRENT_TIMESTAMP;
  END IF;
END;

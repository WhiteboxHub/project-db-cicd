ALTER TABLE vendor_contact_extracts
ADD COLUMN moved_at TIMESTAMP NULL AFTER moved_to_vendor;

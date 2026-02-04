DELETE FROM vendor_contact_extracts
WHERE moved_to_vendor = 1
  AND created_at < '2026-01-31 00:00:00';

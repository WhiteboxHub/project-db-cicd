DROP TRIGGER IF EXISTS vendor_contact_extracts_before_update;
DELIMITER $$

CREATE TRIGGER vendor_contact_extracts_before_update
BEFORE UPDATE ON vendor_contact_extracts
FOR EACH ROW
BEGIN
    IF NEW.moved_to_vendor = 1 AND OLD.moved_to_vendor = 0 THEN
        SET NEW.moved_at = NOW();
    END IF;
END$$

DELIMITER ;

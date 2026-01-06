-- Check if table exists
SET @tbl_exists = (
    SELECT COUNT(*)
    FROM information_schema.tables
    WHERE table_schema = 'testdb'
      AND table_name = 'vendor_contact_extracts'
);

-- Prepare the trigger creation SQL only if table exists
SET @sql_text = IF(@tbl_exists > 0,
'
CREATE TRIGGER move_to_vendor_after_update
AFTER UPDATE ON vendor_contact_extracts
FOR EACH ROW
BEGIN
    DECLARE v_vendor_id INT DEFAULT NULL;

    -- Run only when record is moved to vendor
    IF NEW.moved_to_vendor = 1 AND OLD.moved_to_vendor = 0 THEN

        -- Match by LinkedIn
        IF NEW.linkedin_internal_id IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE linkedin_internal_id = NEW.linkedin_internal_id
            LIMIT 1;
        END IF;

        -- Match by Email
        IF v_vendor_id IS NULL AND NEW.email IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE email = NEW.email
            LIMIT 1;
        END IF;

        -- Match by Phone
        IF v_vendor_id IS NULL AND NEW.phone IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE phone_number = NEW.phone
            LIMIT 1;
        END IF;

        -- Update existing vendor
        IF v_vendor_id IS NOT NULL THEN
            UPDATE vendor
            SET
                full_name = COALESCE(vendor.full_name, NEW.full_name),
                email = COALESCE(vendor.email, NEW.email),
                phone_number = COALESCE(vendor.phone_number, NEW.phone),
                linkedin_id = COALESCE(vendor.linkedin_id, NEW.linkedin_id),
                linkedin_internal_id = COALESCE(vendor.linkedin_internal_id, NEW.linkedin_internal_id),
                company_name = COALESCE(vendor.company_name, NEW.company_name),
                location = COALESCE(vendor.location, NEW.location)
            WHERE id = v_vendor_id;

        -- Insert new vendor
        ELSE
            INSERT INTO vendor (
                full_name,
                phone_number,
                email,
                linkedin_id,
                linkedin_internal_id,
                company_name,
                location,
                created_at
            )
            VALUES (
                NEW.full_name,
                NEW.phone,
                NEW.email,
                NEW.linkedin_id,
                NEW.linkedin_internal_id,
                NEW.company_name,
                NEW.location,
                NOW()
            );

            SET v_vendor_id = LAST_INSERT_ID();
        END IF;

        -- Link extraction to vendor
        UPDATE vendor_contact_extracts
        SET vendor_id = v_vendor_id
        WHERE id = NEW.id;

    END IF;
END;
', NULL);
-- Execute the trigger creation if table exists
PREPARE stmt FROM @sql_text;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

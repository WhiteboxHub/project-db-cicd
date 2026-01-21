DROP TRIGGER IF EXISTS move_to_vendor_before_update;
DELIMITER $$

CREATE TRIGGER move_to_vendor_before_update
BEFORE UPDATE ON vendor_contact_extracts
FOR EACH ROW
BEGIN
    DECLARE v_vendor_id INT DEFAULT NULL;
    DECLARE v_notes TEXT DEFAULT '';

    IF NEW.moved_to_vendor = 1 AND OLD.moved_to_vendor = 0 THEN

        -- Duplicate check

        IF NEW.linkedin_internal_id IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE linkedin_internal_id = NEW.linkedin_internal_id
            LIMIT 1;
        END IF;

        IF v_vendor_id IS NULL AND NEW.linkedin_id IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE linkedin_id = NEW.linkedin_id
            LIMIT 1;
        END IF;

        IF v_vendor_id IS NULL AND NEW.email IS NOT NULL THEN
            SELECT id INTO v_vendor_id
            FROM vendor
            WHERE email = NEW.email
            LIMIT 1;
        END IF;

        -- Duplicate found → update notes
        IF v_vendor_id IS NOT NULL THEN

            SELECT CONCAT_WS('\n',
                'Duplicate detected via identity match',
                IF(NEW.full_name IS NOT NULL AND NEW.full_name <> full_name,
                   CONCAT('Alt name: ', NEW.full_name), NULL),
                IF(NEW.email IS NOT NULL AND NEW.email <> email,
                   CONCAT('Alt email: ', NEW.email), NULL),
                IF(NEW.phone IS NOT NULL AND NEW.phone <> phone_number,
                   CONCAT('Alt phone: ', NEW.phone), NULL),
                IF(NEW.company_name IS NOT NULL AND NEW.company_name <> company_name,
                   CONCAT('Alt company: ', NEW.company_name), NULL),
                IF(NEW.location IS NOT NULL AND NEW.location <> location,
                   CONCAT('Alt location: ', NEW.location), NULL),
                CONCAT('Source extract ID: ', NEW.id)
            )
            INTO v_notes
            FROM vendor
            WHERE id = v_vendor_id;

            UPDATE vendor
            SET notes = CONCAT_WS('\n', notes, v_notes)
            WHERE id = v_vendor_id;

        -- Not duplicate → insert vendor
        ELSE
            INSERT INTO vendor (
                full_name,
                email,
                linkedin_id,
                linkedin_internal_id,
                company_name,
                location,
                type,
                status,
                notes
            )
            VALUES (
                NEW.full_name,
                NEW.email,
                NEW.linkedin_id,
                NEW.linkedin_internal_id,
                NEW.company_name,
                NEW.location,
                'third-party-vendor',
                'prospect',
                CONCAT('Created from extract ID: ', NEW.id)
            );

            SET v_vendor_id = LAST_INSERT_ID();
        END IF;

        -- SAFE: modify the row being updated
        SET NEW.vendor_id = v_vendor_id;

    END IF;
END$$
DELIMITER ;

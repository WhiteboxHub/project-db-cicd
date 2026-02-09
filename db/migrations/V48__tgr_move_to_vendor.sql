-- Drop trigger if it exists (for idempotency)
DROP TRIGGER IF EXISTS trg_move_old_contacts_to_vendor;

-- Create trigger to automatically move old vendor contact extracts to vendor table
CREATE TRIGGER trg_move_old_contacts_to_vendor
AFTER INSERT ON vendor_contact_extracts
FOR EACH ROW
BEGIN
    DECLARE v_vendor_id INT;
    DECLARE v_notes TEXT DEFAULT '';

    -- Only process records older than 2 weeks
    IF NEW.extraction_date <= CURDATE() - INTERVAL 14 DAY THEN

        -- Find duplicate vendor using email OR linkedin_id OR linkedin_internal_id
        SELECT id
        INTO v_vendor_id
        FROM vendor
        WHERE
            (NEW.email IS NOT NULL AND email = NEW.email)
            OR (NEW.linkedin_id IS NOT NULL AND linkedin_id = NEW.linkedin_id)
            OR (NEW.linkedin_internal_id IS NOT NULL AND linkedin_internal_id = NEW.linkedin_internal_id)
        LIMIT 1;

        -- =========================
        -- NO DUPLICATE → INSERT
        -- =========================
        IF v_vendor_id IS NULL THEN

            INSERT INTO vendor (
                full_name,
                phone_number,
                email,
                linkedin_id,
                linkedin_internal_id,
                company_name,
                location,
                notes
            )
            VALUES (
                NEW.full_name,
                NEW.phone,
                NEW.email,
                NEW.linkedin_id,
                NEW.linkedin_internal_id,
                NEW.company_name,
                NEW.location,
                CONCAT('Imported from vendor_contact_extracts on ', CURDATE())
            );

            SET v_vendor_id = LAST_INSERT_ID();

        -- =========================
        -- DUPLICATE FOUND → UPDATE NOTES
        -- =========================
        ELSE

            -- Compare and capture differences
            SELECT CONCAT(
                IF(v.full_name <> NEW.full_name AND NEW.full_name IS NOT NULL,
                   CONCAT('Name changed: ', v.full_name, ' → ', NEW.full_name, '; '), ''),
                IF(v.phone_number <> NEW.phone AND NEW.phone IS NOT NULL,
                   CONCAT('Phone changed: ', v.phone_number, ' → ', NEW.phone, '; '), ''),
                IF(v.company_name <> NEW.company_name AND NEW.company_name IS NOT NULL,
                   CONCAT('Company changed: ', v.company_name, ' → ', NEW.company_name, '; '), ''),
                IF(v.location <> NEW.location AND NEW.location IS NOT NULL,
                   CONCAT('Location changed: ', v.location, ' → ', NEW.location, '; '), '')
            )
            INTO v_notes
            FROM vendor v
            WHERE v.id = v_vendor_id;

            -- Update vendor only if differences exist
            IF v_notes IS NOT NULL AND v_notes <> '' THEN
                UPDATE vendor
                SET
                    notes = CONCAT(IFNULL(notes, ''), ' | ', v_notes),
                    created_at = CURRENT_TIMESTAMP
                WHERE id = v_vendor_id;
            END IF;

        END IF;

        -- Update extract record
        UPDATE vendor_contact_extracts
        SET
            moved_to_vendor = 1,
            vendor_id = v_vendor_id
        WHERE id = NEW.id;

    END IF;
END;

DROP TRIGGER IF EXISTS trg_move_old_contacts_to_vendor;
/* =========================================================
   Drop existing event (Flyway idempotency)
========================================================= */

DROP EVENT IF EXISTS ev_move_old_contacts;


/* =========================================================
   Event: Move old contacts to vendor table
   (Converted from trigger logic)
========================================================= */

DELIMITER $$

CREATE EVENT ev_move_old_contacts
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 15 MINUTE
ON COMPLETION PRESERVE
ENABLE
DO
BEGIN

    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_vendor_id INT;
    DECLARE v_notes TEXT DEFAULT '';

    /* Cursor for eligible records */
    DECLARE cur_contacts CURSOR FOR
        SELECT id
        FROM vendor_contact_extracts
        WHERE moved_to_vendor = 0
          AND extraction_date <= CURDATE() - INTERVAL 14 DAY;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_contacts;

    read_loop: LOOP

        FETCH cur_contacts INTO v_id;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        /* =========================
           Find duplicate vendor
        ========================= */
        SELECT id
        INTO v_vendor_id
        FROM vendor v
        JOIN vendor_contact_extracts e ON e.id = v_id
        WHERE
            (e.email IS NOT NULL AND v.email = e.email)
            OR (e.linkedin_id IS NOT NULL AND v.linkedin_id = e.linkedin_id)
            OR (e.linkedin_internal_id IS NOT NULL AND v.linkedin_internal_id = e.linkedin_internal_id)
        LIMIT 1;

        /* =========================
           NO DUPLICATE → INSERT
        ========================= */
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
            SELECT
                full_name,
                phone,
                email,
                linkedin_id,
                linkedin_internal_id,
                company_name,
                location,
                CONCAT('Imported from vendor_contact_extracts on ', CURDATE())
            FROM vendor_contact_extracts
            WHERE id = v_id;

            SET v_vendor_id = LAST_INSERT_ID();

        /* =========================
           DUPLICATE → UPDATE NOTES
        ========================= */
        ELSE

            SELECT CONCAT(
                IF(v.full_name <> e.full_name AND e.full_name IS NOT NULL,
                   CONCAT('Name changed: ', v.full_name, ' → ', e.full_name, '; '), ''),
                IF(v.phone_number <> e.phone AND e.phone IS NOT NULL,
                   CONCAT('Phone changed: ', v.phone_number, ' → ', e.phone, '; '), ''),
                IF(v.company_name <> e.company_name AND e.company_name IS NOT NULL,
                   CONCAT('Company changed: ', v.company_name, ' → ', e.company_name, '; '), ''),
                IF(v.location <> e.location AND e.location IS NOT NULL,
                   CONCAT('Location changed: ', v.location, ' → ', e.location, '; '), '')
            )
            INTO v_notes
            FROM vendor v
            JOIN vendor_contact_extracts e ON e.id = v_id
            WHERE v.id = v_vendor_id;

            IF v_notes IS NOT NULL AND v_notes <> '' THEN
                UPDATE vendor
                SET
                    notes = CONCAT(IFNULL(notes,''),' | ',v_notes),
                    created_at = CURRENT_TIMESTAMP
                WHERE id = v_vendor_id;
            END IF;

        END IF;

        /* =========================
           Mark extract as moved
        ========================= */
        UPDATE vendor_contact_extracts
        SET
            moved_to_vendor = 1,
            vendor_id = v_vendor_id
        WHERE id = v_id;

    END LOOP;

    CLOSE cur_contacts;

END$$

DELIMITER ;

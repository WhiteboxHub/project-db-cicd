/* =========================================================
   Enable MySQL Event Scheduler
   NOTE:
   - Requires SUPER or SYSTEM_VARIABLES_ADMIN privilege
   - Safe to run multiple times
========================================================= */

SET GLOBAL event_scheduler = ON;


/* =========================================================
   Create event log table (optional but recommended)
========================================================= */

CREATE TABLE IF NOT EXISTS event_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    deleted_rows INT,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* =========================================================
   Drop existing event (Flyway idempotency)
========================================================= */

DROP EVENT IF EXISTS ev_delete_moved_contacts;


/* =========================================================
   Create Cleanup Event
   Deletes contacts already moved to vendor table
========================================================= */

DELIMITER $$

CREATE EVENT ev_delete_moved_contacts
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
ON COMPLETION PRESERVE
ENABLE
DO
BEGIN

    DECLARE v_deleted INT DEFAULT 0;

    /* Delete moved records older than 14 days */
    DELETE FROM vendor_contact_extracts
    WHERE moved_to_vendor = 1
      AND extraction_date <= CURDATE() - INTERVAL 14 DAY;

    /* Capture number of deleted rows */
    SET v_deleted = ROW_COUNT();

    /* Log execution */
    INSERT INTO event_logs(event_name, deleted_rows)
    VALUES ('ev_delete_moved_contacts', v_deleted);

END$$

DELIMITER ;

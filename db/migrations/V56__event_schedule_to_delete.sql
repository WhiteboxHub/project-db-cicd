/* =========================================================
   1️⃣ Create event log table (safe & idempotent)
========================================================= */

CREATE TABLE IF NOT EXISTS event_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    deleted_rows INT DEFAULT 0,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* =========================================================
   2️⃣ Drop existing event (Flyway re-run safe)
========================================================= */

DROP EVENT IF EXISTS ev_delete_moved_contacts;


/* =========================================================
   3️⃣ Create cleanup event
   Deletes records moved to vendor table older than 14 days
========================================================= */

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

END;

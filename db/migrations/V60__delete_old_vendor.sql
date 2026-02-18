/* =========================================================
   Create event log table (optional safety logging)
========================================================= */

CREATE TABLE IF NOT EXISTS event_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    deleted_rows INT,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* =========================================================
   Drop existing cleanup event
========================================================= */

DROP EVENT IF EXISTS ev_delete_moved_contacts;


/* =========================================================
   Create Cleanup Event
========================================================= */

DELIMITER $$

CREATE EVENT ev_delete_moved_contacts
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 5 MINUTE
ON COMPLETION PRESERVE
ENABLE
DO
BEGIN

    DECLARE v_deleted INT DEFAULT 0;

    DELETE FROM vendor_contact_extracts
    WHERE moved_to_vendor = 1
      AND COALESCE(extraction_date, DATE(created_at))
          <= CURDATE() - INTERVAL 14 DAY;

    SET v_deleted = ROW_COUNT();

    INSERT INTO event_logs(event_name, deleted_rows)
    VALUES ('ev_delete_moved_contacts', v_deleted);

END$$

DELIMITER ;

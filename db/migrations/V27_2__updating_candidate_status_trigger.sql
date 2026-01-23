DROP TRIGGER IF EXISTS trg_candidate_status_sync;

DELIMITER $$

CREATE TRIGGER trg_candidate_status_sync
AFTER UPDATE ON candidate
FOR EACH ROW
BEGIN
    /* =====================================================
       CASE 1: Candidate becomes INACTIVE / BREAK / CLOSED / DISCONTINUED
       ===================================================== */
    IF OLD.status <> NEW.status
       AND NEW.status IN ('inactive','break','closed','discontinued') THEN

        UPDATE candidate_preparation
        SET status = 'inactive'
        WHERE candidate_id = NEW.id
          AND status = 'active';

        UPDATE candidate_marketing
        SET status = 'inactive'
        WHERE candidate_id = NEW.id
          AND status = 'active';

    END IF;

    /* =====================================================
       CASE 2: Candidate becomes ACTIVE from non-active state
       ===================================================== */
    IF OLD.status IN ('inactive','break','closed','discontinued')
       AND NEW.status = 'active' THEN

        UPDATE candidate
        SET move_to_prep = 0
        WHERE id = NEW.id;

    END IF;

END$$

DELIMITER ;

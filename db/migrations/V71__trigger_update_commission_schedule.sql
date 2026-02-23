DELIMITER $$

CREATE TRIGGER trg_update_commission_schedule
AFTER UPDATE ON placement_commission
FOR EACH ROW
BEGIN
    IF NEW.amount <> OLD.amount
       OR NEW.placement_id <> OLD.placement_id THEN

        DELETE FROM placement_commission_scheduler
        WHERE placement_commission_id = NEW.id;

        CALL generate_commission_schedule(NEW.id);

    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_generate_commission_schedule
AFTER INSERT ON placement_commission
FOR EACH ROW
BEGIN
    CALL generate_commission_schedule(NEW.id);
END $$

DELIMITER ;

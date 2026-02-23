DELIMITER $$

CREATE PROCEDURE generate_commission_schedule (
    IN p_commission_id INT
)
proc_main: BEGIN

    DECLARE v_amount DECIMAL(10,2);
    DECLARE v_installment DECIMAL(10,2);
    DECLARE v_join_date DATE;
    DECLARE v_exists INT DEFAULT 0;

    -- Check if schedule already exists
    SELECT COUNT(*) INTO v_exists
    FROM placement_commission_scheduler
    WHERE placement_commission_id = p_commission_id;

    IF v_exists > 0 THEN
        LEAVE proc_main;
    END IF;

    -- Get commission amount and joining date
    SELECT pc.amount, cp.joining_date
    INTO v_amount, v_join_date
    FROM placement_commission pc
    JOIN candidate_placement cp
        ON pc.placement_id = cp.id
    WHERE pc.id = p_commission_id;

    -- Exit if joining date missing
    IF v_join_date IS NULL THEN
        LEAVE proc_main;
    END IF;

    -- Calculate installment
    SET v_installment = ROUND(v_amount / 3, 2);

    -- Insert schedule
    INSERT INTO placement_commission_scheduler
    (placement_commission_id, installment_no, installment_amount, scheduled_date)
    VALUES
        (p_commission_id, 1, v_installment, v_join_date),

        (p_commission_id, 2, v_installment,
            DATE_ADD(v_join_date, INTERVAL 1 MONTH)),

        (p_commission_id, 3,
            v_amount - (v_installment * 2),
            DATE_ADD(v_join_date, INTERVAL 2 MONTH));

END proc_main$$

DELIMITER ;

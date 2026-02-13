ALTER TABLE candidate_marketing
ADD COLUMN run_daily_workflow TINYINT NOT NULL DEFAULT 0;

ALTER TABLE candidate_marketing
ADD COLUMN run_weekly_workflow TINYINT NOT NULL DEFAULT 0;



DROP TRIGGER IF EXISTS trg_prepare_daily_vendor_workflow;
DROP TRIGGER IF EXISTS trg_prepare_weekly_vendor_workflow;




DELIMITER $$

CREATE TRIGGER trg_prepare_daily_vendor_workflow
AFTER UPDATE ON candidate_marketing
FOR EACH ROW
BEGIN
    IF NEW.run_daily_workflow = 1
       AND OLD.run_daily_workflow = 0 THEN

        UPDATE automation_workflows_schedule s
        JOIN automation_workflows w
          ON s.automation_workflow_id = w.id
        SET s.run_parameters = JSON_OBJECT(
            'candidate_id', NEW.candidate_id,
            'email', NEW.email,
            'imap_password', NEW.imap_password,
            'linkedin_username', NEW.linkedin_username,
            'linkedin_passwd', NEW.linkedin_passwd,
            'trigger_type', 'daily',
            'activated_at', NOW()
        )
        WHERE w.workflow_key = 'daily_vendor_outreach'
          AND s.enabled = 1;

    END IF;
END$$


-- ==========================================
-- Create Weekly Workflow Trigger
-- ==========================================

CREATE TRIGGER trg_prepare_weekly_vendor_workflow
AFTER UPDATE ON candidate_marketing
FOR EACH ROW
BEGIN
    IF NEW.run_weekly_workflow = 1
       AND OLD.run_weekly_workflow = 0 THEN

        UPDATE automation_workflows_schedule s
        JOIN automation_workflows w
          ON s.automation_workflow_id = w.id
        SET s.run_parameters = JSON_OBJECT(
            'candidate_id', NEW.candidate_id,
            'email', NEW.email,
            'imap_password', NEW.imap_password,
            'linkedin_username', NEW.linkedin_username,
            'linkedin_passwd', NEW.linkedin_passwd,
            'trigger_type', 'weekly',
            'activated_at', NOW()
        )
        WHERE w.workflow_key = 'weekly_vendor_outreach'
          AND s.enabled = 1;

    END IF;
END$$

DELIMITER ;

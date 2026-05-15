-- ============================================================================
-- weekly_outreach_trigger.sql
-- ============================================================================
-- Based on deployed trigger versions confirmed working in production.
--
-- TRIGGER 1: trg_candidate_marketing_outreach
--   ON:   candidate_marketing  BEFORE UPDATE
--   WHEN: run_outreach_emails changes 0 → 1
--   DOES:
--     - Dedup: checks automation_workflows_schedule directly (no lock table)
--     - Validates candidate has full_name + email
--     - Calculates next weekday run time at 9 AM ± 0–29 min random offset
--     - Inserts 'custom' Mon–Fri schedule for workflow_id=3
--     - Flag stays = 1 while campaign is active
--
-- TRIGGER 2: trg_schedule_outreach_completion
--   ON:   automation_workflows_schedule  AFTER UPDATE
--   WHEN: enabled changes 1 → 0  AND  frequency = 'custom'
--   DOES:
--     - Extracts candidate_id from run_parameters JSON
--     - Resets candidate_marketing.run_outreach_emails = 0
--     - Safety net: Python scheduler already calls execute-reset-sql for this
--
-- CONFIRMED SCHEMA:
--   - automation_workflows: id=3, workflow_key='weekly_vendor_outreach', status='active'
--   - automation_workflows_schedule: enabled TINYINT(1), is_running TINYINT(1),
--       frequency ENUM(...,'custom',...), run_parameters JSON, next_run_at DATETIME(6)
--   - candidate_marketing: candidate_id INT, run_outreach_emails, email
--   - candidate: id INT, full_name, linkedin_id, email
-- ============================================================================


DELIMITER $$

-- ============================================================================
-- TRIGGER 1: Create weekday schedule when flag is enabled
-- ============================================================================
DROP TRIGGER IF EXISTS trg_candidate_marketing_outreach

CREATE TRIGGER trg_candidate_marketing_outreach
BEFORE UPDATE ON candidate_marketing
FOR EACH ROW
BEGIN

    DECLARE v_candidate_name   VARCHAR(100) DEFAULT NULL;
    DECLARE v_linkedin_url     VARCHAR(200) DEFAULT NULL;

    DECLARE v_found            TINYINT(1)   DEFAULT 0;
    DECLARE v_next_run         DATETIME     DEFAULT NULL;

    -- Fire only on 0 → 1 transition
    IF OLD.run_outreach_emails = 0
       AND NEW.run_outreach_emails = 1 THEN

        -- Dedup check
        IF NOT EXISTS (
            SELECT 1
            FROM automation_workflows_schedule
            WHERE automation_workflow_id = 3
              AND frequency = 'custom'
              AND enabled = 1
              AND JSON_UNQUOTE(
                    JSON_EXTRACT(run_parameters, '$.candidate_id')
                  ) = CAST(NEW.candidate_id AS CHAR)
        ) THEN

            -- Fetch candidate details
            SELECT
                c.full_name,
                c.linkedin_id,
                1
            INTO
                v_candidate_name,
                v_linkedin_url,
                v_found
            FROM candidate c
            WHERE c.id = NEW.candidate_id
            LIMIT 1;

            -- Validation
            IF v_found = 0 THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Outreach trigger: candidate not found.';
            END IF;

            IF v_candidate_name IS NULL
               OR TRIM(v_candidate_name) = '' THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Outreach trigger: candidate.full_name is empty.';
            END IF;

            IF NEW.email IS NULL
               OR TRIM(NEW.email) = '' THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Outreach trigger: candidate_marketing.email is empty.';
            END IF;

            -- Calculate next run time
            -- Runs EVERY DAY including weekends
            SET v_next_run = CASE

                -- Before 9 AM → today
                WHEN TIME(NOW()) < '09:00:00' THEN
                    DATE_ADD(
                        CURDATE(),
                        INTERVAL (9 * 60 + FLOOR(RAND() * 30)) MINUTE
                    )

                -- After 9 AM → tomorrow
                ELSE
                    DATE_ADD(
                        DATE_ADD(CURDATE(), INTERVAL 1 DAY),
                        INTERVAL (9 * 60 + FLOOR(RAND() * 30)) MINUTE
                    )

            END;

            -- Create schedule
            INSERT INTO automation_workflows_schedule (
                automation_workflow_id,
                timezone,
                cron_expression,
                frequency,
                interval_value,
                next_run_at,
                enabled,
                is_running,
                run_parameters,
                created_at,
                updated_at
            )
            VALUES (
                3,
                'America/Los_Angeles',
                '0 9 * * *',
                'custom',
                1,
                v_next_run,
                1,
                0,
                JSON_OBJECT(
                    'candidate_id',    NEW.candidate_id,
                    'candidate_name',  TRIM(v_candidate_name),
                    'linkedin_url',    COALESCE(TRIM(v_linkedin_url), ''),
                    'candidate_email', COALESCE(TRIM(NEW.email), '')
                ),
                NOW(),
                NOW()
            );

        END IF;

    END IF;

END


-- ============================================================================
-- TRIGGER 2: Reset flag when scheduler marks campaign complete
-- ============================================================================
DROP TRIGGER IF EXISTS trg_schedule_outreach_completion$$

CREATE TRIGGER trg_schedule_outreach_completion
AFTER UPDATE ON automation_workflows_schedule
FOR EACH ROW
BEGIN

    DECLARE v_candidate_id BIGINT UNSIGNED DEFAULT NULL;

    -- Fire only when enabled changes 1 → 0 on a 'custom' frequency schedule
    IF (
        OLD.enabled   = 1
        AND NEW.enabled   = 0
        AND NEW.frequency = 'custom'
    ) THEN

        -- Extract candidate_id from run_parameters JSON
        SET v_candidate_id = CAST(
            JSON_UNQUOTE(
                JSON_EXTRACT(NEW.run_parameters, '$.candidate_id')
            ) AS UNSIGNED
        );

        -- Reset outreach flag (safety net)
        IF v_candidate_id IS NOT NULL
           AND v_candidate_id > 0 THEN

            UPDATE candidate_marketing
            SET    run_outreach_emails = 0
            WHERE  candidate_id        = v_candidate_id
              AND  run_outreach_emails  = 1;

        END IF;

    END IF;

END$$

DELIMITER ;

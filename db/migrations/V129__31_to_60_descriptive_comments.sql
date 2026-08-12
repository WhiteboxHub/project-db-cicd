-- Add comments only when the target table exists.
-- Required because some tables exist in the production dump but are not
-- created by the Flyway migration chain used by CI.

DELIMITER $$

DROP PROCEDURE IF EXISTS add_table_comment_if_exists$$

CREATE PROCEDURE add_table_comment_if_exists(
    IN target_table VARCHAR(64),
    IN descriptive_comment TEXT
)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.TABLES
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = target_table
          AND TABLE_TYPE = 'BASE TABLE'
    ) THEN
        SET @comment_sql = CONCAT(
            'ALTER TABLE `',
            REPLACE(target_table, '`', '``'),
            '` COMMENT = ',
            QUOTE(descriptive_comment)
        );

        PREPARE comment_statement FROM @comment_sql;
        EXECUTE comment_statement;
        DEALLOCATE PREPARE comment_statement;
    END IF;
END$$

DELIMITER ;

CALL add_table_comment_if_exists(
    'email_templates',
    'Stores reusable email templates, including subject, HTML and text content, parameters, version, and operational status.'
);

CALL add_table_comment_if_exists(
    'course',
    'Stores training course definitions, descriptions, aliases, and syllabus information.'
);

CALL add_table_comment_if_exists(
    'course_content',
    'Stores course content references organized by training areas such as Fundamentals, AI/ML, UI, and Quality Engineering.'
);

CALL add_table_comment_if_exists(
    'course_material',
    'Stores subject-specific course materials, including names, descriptions, resource types, links, and display order.'
);

CALL add_table_comment_if_exists(
    'course_subject',
    'Maps courses to their associated training subjects.'
);

CALL add_table_comment_if_exists(
    'email_activity_log',
    'Stores daily candidate marketing email activity, including emails read and vendor emails extracted.'
);

CALL add_table_comment_if_exists(
    'company',
    'Stores company profiles, including names, addresses, contact details, domains, notes, and audit information.'
);

CALL add_table_comment_if_exists(
    'company_contact',
    'Stores contacts associated with companies, including job titles, contact information, addresses, LinkedIn identifiers, and notes.'
);

CALL add_table_comment_if_exists(
    'candidate_resume',
    'Stores candidate resume data in JSON format, including the source file name and creation and update timestamps.'
);

CALL add_table_comment_if_exists(
    'candidate_session',
    'Maps candidates to their assigned or attended training sessions.'
);

CALL add_table_comment_if_exists(
    'cli_usage_events',
    'Stores CLI usage events, command results, execution duration, job-processing totals, and additional event metadata.'
);

CALL add_table_comment_if_exists(
    'clients',
    'Stores employer and client organization names, addresses, telephone details, and creation timestamps.'
);

CALL add_table_comment_if_exists(
    'code_execution_log',
    'Stores candidate code execution history, including source code, inputs, outputs, errors, execution status, and duration.'
);

CALL add_table_comment_if_exists(
    'code_snippet',
    'Stores user-created code snippets, programming language, test cases, sharing configuration, and execution settings.'
);

CALL add_table_comment_if_exists(
    'coderpad_question',
    'Stores CoderPad assessment questions, problem statements, starter code, test cases, candidate assignments, and execution settings.'
);

DROP PROCEDURE IF EXISTS add_table_comment_if_exists;
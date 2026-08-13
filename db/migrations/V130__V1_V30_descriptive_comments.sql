-- ==============================================================================
-- Flyway Migration V130: Add Table Comments (Tables 1 to 30)
-- Target: High-quality functional documentation for active production tables
-- Safely handled via stored procedure to support clean databases in CI/CD
-- ==============================================================================

DELIMITER $$

CREATE PROCEDURE add_table_comment_if_exists(
    IN tbl_name VARCHAR(64),
    IN tbl_comment VARCHAR(1024)
)
BEGIN
    DECLARE table_count INT;
    SELECT COUNT(*) INTO table_count 
    FROM information_schema.tables 
    WHERE table_schema = DATABASE() AND table_name = tbl_name;
    
    IF table_count > 0 THEN
        SET @sql_stmt = CONCAT('ALTER TABLE `', tbl_name, '` COMMENT = ', QUOTE(tbl_comment));
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$

DELIMITER ;

-- Apply comments to all tables safely if they exist
CALL add_table_comment_if_exists('aiprep_tool_attempts', 'Stores candidate mock interview attempt counters partitioned by category to monitor platform usage.');
CALL add_table_comment_if_exists('aiprep_tool_candidates', 'Stores AI Prep candidate accounts, login credentials, encrypted LLM API keys, and session activity.');
CALL add_table_comment_if_exists('aiprep_tool_case_studies', 'Stores technical case studies, interview scenarios, and questions assigned during AI Prep sessions.');
CALL add_table_comment_if_exists('aiprep_tool_coderpad_cache', 'Caches candidate Coderpad performance metrics, including solved questions, submission counts, pass rates, and languages used.');
CALL add_table_comment_if_exists('aiprep_tool_project_context', 'Stores candidate project architecture, tech stack, and background details used to personalize AI interviews.');
CALL add_table_comment_if_exists('aiprep_tool_resumes', 'Stores candidate parsed resume JSON data and resume PDF URLs for AI interview personalization.');
CALL add_table_comment_if_exists('automation_contact_extracts', 'Stores staging recruiter and vendor contacts extracted from automated email digests before deduplication.');
CALL add_table_comment_if_exists('automation_workflows', 'Stores background automation workflow definitions, configurations, handler classes, and active status.');
CALL add_table_comment_if_exists('batch', 'Stores training cohort batches, assigned instructors, curriculum mappings, and start/end dates.');
CALL add_table_comment_if_exists('candidate', 'Stores candidate master profiles including contact details, visa status, skills, and onboarding stage.');
CALL add_table_comment_if_exists('candidate_classes', 'Stores candidate training class enrollments, attendance, grades, and completion records.');
CALL add_table_comment_if_exists('candidate_interview', 'Stores candidate interview schedules, company details, round types, interviewer notes, and audio links.');
CALL add_table_comment_if_exists('candidate_llm_api_keys', 'Stores candidate encrypted LLM provider API keys (OpenAI, Claude, Gemini) and validation statuses.');
CALL add_table_comment_if_exists('company_hr_contacts', 'Stores contact details, company names, and locations of corporate HR professionals and recruiters, indicating immigration team status.');
CALL add_table_comment_if_exists('employee', 'Stores internal employee and instructor profiles, including contact details, employment status, roles, and identification numbers.');
CALL add_table_comment_if_exists('employee_task', 'Stores internal employee task assignments, tracking due dates, priority levels, notes, and execution statuses.');
CALL add_table_comment_if_exists('projects', 'Stores internal project details, capturing project owners, schedule timelines, priority levels, and execution statuses.');


-- Clean up helper procedure
DROP PROCEDURE IF EXISTS add_table_comment_if_exists;

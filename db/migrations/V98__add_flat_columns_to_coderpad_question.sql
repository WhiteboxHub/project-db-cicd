-- Add explicit question numbering and flat test-case columns to coderpad_question.
-- Question is mandatory; test_case_1..test_case_10 are optional.

SET @db := DATABASE();

SET @tbl_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'coderpad_question'
);

-- Add SNo column when missing.
SET @col_sno_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'coderpad_question'
    AND COLUMN_NAME = 'sno'
);
SET @sql_sno := IF(
  @tbl_exists > 0 AND @col_sno_exists = 0,
  'ALTER TABLE `coderpad_question` ADD COLUMN `sno` INT NOT NULL DEFAULT 0 AFTER `id`',
  'SELECT 1'
);
PREPARE stmt FROM @sql_sno;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add question column when missing.
SET @col_question_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = @db
    AND TABLE_NAME = 'coderpad_question'
    AND COLUMN_NAME = 'question'
);
SET @sql_question := IF(
  @tbl_exists > 0 AND @col_question_exists = 0,
  'ALTER TABLE `coderpad_question` ADD COLUMN `question` TEXT NULL AFTER `title`',
  'SELECT 1'
);
PREPARE stmt FROM @sql_question;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add optional flat test-case columns when missing.
SET @col_tc1_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_1');
SET @sql_tc1 := IF(@tbl_exists > 0 AND @col_tc1_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_1` TEXT NULL AFTER `problem_statement`', 'SELECT 1');
PREPARE stmt FROM @sql_tc1; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc2_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_2');
SET @sql_tc2 := IF(@tbl_exists > 0 AND @col_tc2_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_2` TEXT NULL AFTER `test_case_1`', 'SELECT 1');
PREPARE stmt FROM @sql_tc2; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc3_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_3');
SET @sql_tc3 := IF(@tbl_exists > 0 AND @col_tc3_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_3` TEXT NULL AFTER `test_case_2`', 'SELECT 1');
PREPARE stmt FROM @sql_tc3; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc4_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_4');
SET @sql_tc4 := IF(@tbl_exists > 0 AND @col_tc4_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_4` TEXT NULL AFTER `test_case_3`', 'SELECT 1');
PREPARE stmt FROM @sql_tc4; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc5_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_5');
SET @sql_tc5 := IF(@tbl_exists > 0 AND @col_tc5_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_5` TEXT NULL AFTER `test_case_4`', 'SELECT 1');
PREPARE stmt FROM @sql_tc5; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc6_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_6');
SET @sql_tc6 := IF(@tbl_exists > 0 AND @col_tc6_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_6` TEXT NULL AFTER `test_case_5`', 'SELECT 1');
PREPARE stmt FROM @sql_tc6; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc7_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_7');
SET @sql_tc7 := IF(@tbl_exists > 0 AND @col_tc7_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_7` TEXT NULL AFTER `test_case_6`', 'SELECT 1');
PREPARE stmt FROM @sql_tc7; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc8_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_8');
SET @sql_tc8 := IF(@tbl_exists > 0 AND @col_tc8_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_8` TEXT NULL AFTER `test_case_7`', 'SELECT 1');
PREPARE stmt FROM @sql_tc8; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc9_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_9');
SET @sql_tc9 := IF(@tbl_exists > 0 AND @col_tc9_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_9` TEXT NULL AFTER `test_case_8`', 'SELECT 1');
PREPARE stmt FROM @sql_tc9; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_tc10_exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'coderpad_question' AND COLUMN_NAME = 'test_case_10');
SET @sql_tc10 := IF(@tbl_exists > 0 AND @col_tc10_exists = 0, 'ALTER TABLE `coderpad_question` ADD COLUMN `test_case_10` TEXT NULL AFTER `test_case_9`', 'SELECT 1');
PREPARE stmt FROM @sql_tc10; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Backfill SNo and question for existing rows.
SET @sql_backfill_sno := IF(
  @tbl_exists > 0,
  'UPDATE `coderpad_question` SET `sno` = COALESCE(`sort_order`, 0) WHERE `sno` IS NULL OR `sno` = 0',
  'SELECT 1'
);
PREPARE stmt FROM @sql_backfill_sno;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql_backfill_question := IF(
  @tbl_exists > 0,
  'UPDATE `coderpad_question` SET `question` = COALESCE(NULLIF(`problem_statement`, ''''), NULLIF(`title`, ''''), ''Question'') WHERE `question` IS NULL OR TRIM(`question`) = ''''',
  'SELECT 1'
);
PREPARE stmt FROM @sql_backfill_question;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Enforce mandatory question column.
SET @sql_require_question := IF(
  @tbl_exists > 0,
  'ALTER TABLE `coderpad_question` MODIFY COLUMN `question` TEXT NOT NULL',
  'SELECT 1'
);
PREPARE stmt FROM @sql_require_question;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

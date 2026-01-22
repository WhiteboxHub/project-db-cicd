SET @column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'employee_task'
    AND COLUMN_NAME = 'project_id'
);

SET @sql := IF(
  @column_exists = 0,
  'ALTER TABLE employee_task ADD COLUMN project_id INT NULL DEFAULT NULL AFTER employee_id',
  'SELECT 1'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

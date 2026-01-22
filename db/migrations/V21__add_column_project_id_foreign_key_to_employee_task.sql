SET @fk_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'employee_task'
    AND CONSTRAINT_NAME = 'fk_employee_task_project'
);

SET @sql := IF(
  @fk_exists = 0,
  'ALTER TABLE employee_task
     ADD CONSTRAINT fk_employee_task_project
     FOREIGN KEY (project_id)
     REFERENCES projects(id)
     ON DELETE SET NULL
     ON UPDATE CASCADE',
  'SELECT 1'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

ALTER TABLE employee_task
  ADD COLUMN project_id INT NULL AFTER employee_id,
  ADD CONSTRAINT fk_employee_task_project
    FOREIGN KEY (project_id)
    REFERENCES projects (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
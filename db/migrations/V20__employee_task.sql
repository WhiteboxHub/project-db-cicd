CREATE TABLE IF NOT EXISTS employee_task (
  id INT NOT NULL AUTO_INCREMENT,
  employee_id INT NOT NULL,
  task VARCHAR(255) NOT NULL,
  assigned_date DATE NOT NULL,
  due_date DATE NOT NULL,
  status ENUM('pending','in_progress','completed','blocked') 
      DEFAULT 'pending',
  priority ENUM('low','medium','high','urgent') 
      DEFAULT 'medium',
  notes TEXT,
  PRIMARY KEY (id),
  KEY fk_employee_task_employee (employee_id),
  CONSTRAINT fk_employee_task_employee
    FOREIGN KEY (employee_id) 
    REFERENCES employee (id)
    ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb3
  COMMENT='Employee Task Management';
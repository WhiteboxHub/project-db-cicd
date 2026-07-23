-- 1. Convert the authuser role column into a strict ENUM
ALTER TABLE authuser 
MODIFY COLUMN role ENUM('admin', 'employee', 'candidate') DEFAULT 'candidate';

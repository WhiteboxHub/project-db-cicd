-- Backfill existing employees so they don't lose their access
UPDATE authuser a
JOIN employee e ON a.uname = e.email
SET a.role = 'employee'
WHERE a.role IS NULL OR a.role = '';

-- Set up the Admin role for multiple users
UPDATE authuser 
SET role = 'admin' 
WHERE uname IN ('sampath.velupula@gmail.com', 'pathanrazakr745@gmail.com'); 

-- 1. Convert the authuser role column into a strict ENUM
ALTER TABLE authuser 
MODIFY COLUMN role ENUM('admin', 'employee', 'candidate') DEFAULT 'candidate';

-- 2. Add missing columns to candidate_marketing that were causing the production crash
ALTER TABLE candidate_marketing 
ADD COLUMN My_Resume LONGBLOB NULL,
ADD COLUMN my_resume_filename VARCHAR(255) NULL;

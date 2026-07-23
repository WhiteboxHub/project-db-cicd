-- Backfill existing employees so they don't lose their access
UPDATE authuser a
JOIN employee e ON a.uname = e.email
SET a.role = 'employee'
WHERE a.role IS NULL OR a.role = '';

-- Set up the Admin role
UPDATE authuser 
SET role = 'admin' 
WHERE uname IN ('sampath.velupula@gmail.com', 'pathanrazakr745@gmail.com');



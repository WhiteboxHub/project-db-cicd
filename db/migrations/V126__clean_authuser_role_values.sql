-- Clean and backfill authuser role values

-- 1. Convert capitalized / mixed-case role values to lowercase (e.g. 'Employee' -> 'employee', 'Candidate' -> 'candidate')
UPDATE authuser 
SET role = LOWER(TRIM(role))
WHERE role IS NOT NULL AND role != '';

-- 2. Default remaining NULL, empty, or invalid role values to 'candidate'
UPDATE authuser 
SET role = 'candidate' 
WHERE role IS NULL OR role = '' OR role NOT IN ('admin', 'employee', 'candidate');

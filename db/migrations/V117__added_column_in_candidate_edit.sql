ALTER TABLE candidate
ADD COLUMN enrollment_status VARCHAR(50) DEFAULT 'not completed' NULL,
ADD COLUMN placement_percentage INT DEFAULT 13 NULL;

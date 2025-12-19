-- 1. Add new job_owners  column
ALTER TABLE job_types
ADD COLUMN job_owner_1 INT DEFAULT NULL,
ADD COLUMN job_owner_2 INT DEFAULT NULL,
ADD COLUMN job_owner_3 INT DEFAULT NULL,
ADD COLUMN category ENUM('manual','automation') NOT NULL DEFAULT 'manual';

-- 2. Add foreign key constraints
ALTER TABLE job_types
ADD CONSTRAINT fk_job_types_job_owner_1 FOREIGN KEY (job_owner_1) REFERENCES employee(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_job_types_job_owner_2 FOREIGN KEY (job_owner_2) REFERENCES employee(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_job_types_job_owner_3 FOREIGN KEY (job_owner_3) REFERENCES employee(id) ON DELETE SET NULL;

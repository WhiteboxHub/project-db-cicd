-- Step 1: structural changes
ALTER TABLE job_types
  DROP FOREIGN KEY fk_job_types_job_owner,
  DROP INDEX fk_job_types_job_owner,
  CHANGE COLUMN job_owner job_owner_1 INT DEFAULT NULL,
  ADD COLUMN job_owner_2 INT DEFAULT NULL,
  ADD COLUMN job_owner_3 INT DEFAULT NULL,
  ADD COLUMN category ENUM('manual','automation') NOT NULL DEFAULT 'manual';

-- Step 2: indexes + FKs
ALTER TABLE job_types
  ADD KEY fk_job_types_job_owner_1 (job_owner_1),
  ADD KEY fk_job_types_job_owner_2 (job_owner_2),
  ADD KEY fk_job_types_job_owner_3 (job_owner_3),
  ADD CONSTRAINT fk_job_types_job_owner_1
    FOREIGN KEY (job_owner_1) REFERENCES employee(id) ON DELETE SET NULL,
  ADD CONSTRAINT fk_job_types_job_owner_2
    FOREIGN KEY (job_owner_2) REFERENCES employee(id) ON DELETE SET NULL,
  ADD CONSTRAINT fk_job_types_job_owner_3
    FOREIGN KEY (job_owner_3) REFERENCES employee(id) ON DELETE SET NULL;

-- Safety checks (optional but recommended)
-- Ensure job_types exists before altering
-- (Flyway best practice: table creation should be in earlier migration)

ALTER TABLE job_types
  ADD COLUMN job_owner_1 BIGINT NULL,
  ADD COLUMN job_owner_2 BIGINT NULL,
  ADD COLUMN job_owner_3 BIGINT NULL,
  ADD COLUMN category ENUM('manual','automation') NOT NULL DEFAULT 'manual';

ALTER TABLE job_types
  ADD CONSTRAINT fk_job_types_job_owner_1
    FOREIGN KEY (job_owner_1) REFERENCES employee(id) ON DELETE SET NULL,
  ADD CONSTRAINT fk_job_types_job_owner_2
    FOREIGN KEY (job_owner_2) REFERENCES employee(id) ON DELETE SET NULL,
  ADD CONSTRAINT fk_job_types_job_owner_3
    FOREIGN KEY (job_owner_3) REFERENCES employee(id) ON DELETE SET NULL;

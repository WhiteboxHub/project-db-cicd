-- Only run if table exists
SET @table_exists := (
  SELECT COUNT(*)
  FROM information_schema.tables
  WHERE table_schema = DATABASE()
    AND table_name = 'job_types'
);

SET @sql := IF(
  @table_exists = 1,
  '
  ALTER TABLE job_types
    ADD COLUMN job_owner_1 BIGINT DEFAULT NULL,
    ADD COLUMN job_owner_2 BIGINT DEFAULT NULL,
    ADD COLUMN job_owner_3 BIGINT DEFAULT NULL,
    ADD COLUMN category ENUM(''manual'',''automation'') NOT NULL DEFAULT ''manual'',
    ADD CONSTRAINT fk_job_types_job_owner_1
      FOREIGN KEY (job_owner_1) REFERENCES employee(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_job_types_job_owner_2
      FOREIGN KEY (job_owner_2) REFERENCES employee(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_job_types_job_owner_3
      FOREIGN KEY (job_owner_3) REFERENCES employee(id) ON DELETE SET NULL;
  ',
  'SELECT 1;'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

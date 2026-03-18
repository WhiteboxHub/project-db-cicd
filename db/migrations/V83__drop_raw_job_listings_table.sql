-- Step 1: Drop FK constraint only if it exists
SET @fk_exists = (
  SELECT COUNT(*) 
  FROM information_schema.TABLE_CONSTRAINTS 
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'job_listing'
    AND CONSTRAINT_NAME = 'fk_job_listing_raw'
    AND CONSTRAINT_TYPE = 'FOREIGN KEY'
);

SET @drop_fk = IF(@fk_exists > 0, 
  'ALTER TABLE `job_listing` DROP FOREIGN KEY `fk_job_listing_raw`', 
  'SELECT 1'
);
PREPARE stmt FROM @drop_fk;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Step 2: Drop the index only if it exists
SET @idx_exists = (
  SELECT COUNT(*) 
  FROM information_schema.STATISTICS 
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'job_listing'
    AND INDEX_NAME = 'fk_job_listing_raw'
);

SET @drop_idx = IF(@idx_exists > 0, 
  'ALTER TABLE `job_listing` DROP INDEX `fk_job_listing_raw`', 
  'SELECT 1'
);
PREPARE stmt FROM @drop_idx;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Step 3: Drop the table
DROP TABLE IF EXISTS `raw_job_listings`;
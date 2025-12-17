-- Step 1: Check if the legacy table exists
    SET @table_exists := (
        SELECT COUNT(*)
        FROM information_schema.tables
        WHERE table_schema = DATABASE()
            AND table_name = 'xx_candidate_old'
    );

-- Step 2: Build SQL dynamically
    SET @sql := IF(
        @table_exists > 0,
        'ALTER TABLE xx_candidate_old RENAME TO xxx_candidate_old',
        'SELECT 1'
    );

-- Step 3: Execute the SQL safely
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

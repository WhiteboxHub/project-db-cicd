-- candidate_llm_api_keys: multiple API keys per candidate (multiple providers, multiple rows).
-- Only this table is created/altered here. No other tables are modified or dropped.

CREATE TABLE IF NOT EXISTS candidate_llm_api_keys (
  id INT NOT NULL AUTO_INCREMENT,
  candidate_id INT NOT NULL,
  provider_name VARCHAR(100) NOT NULL,
  api_key TEXT NOT NULL,
  model_name VARCHAR(200) DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_used_at TIMESTAMP NULL DEFAULT NULL,
  voice_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  is_default BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (id),
  KEY idx_candidate_llm_keys_candidate (candidate_id),
  KEY idx_candidate_llm_keys_candidate_provider (candidate_id, provider_name),
  CONSTRAINT fk_candidate_llm_api_keys_candidate
    FOREIGN KEY (candidate_id) REFERENCES candidate (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET @col_created_at := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'candidate_llm_api_keys' AND column_name = 'created_at'
);
SET @sql_created_at := IF(
  @col_created_at = 0,
  'ALTER TABLE candidate_llm_api_keys ADD COLUMN created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP',
  'SELECT 1'
);
PREPARE stmt_created_at FROM @sql_created_at;
EXECUTE stmt_created_at;
DEALLOCATE PREPARE stmt_created_at;

SET @col_updated_at := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'candidate_llm_api_keys' AND column_name = 'updated_at'
);
SET @sql_updated_at := IF(
  @col_updated_at = 0,
  'ALTER TABLE candidate_llm_api_keys ADD COLUMN updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  'SELECT 1'
);
PREPARE stmt_updated_at FROM @sql_updated_at;
EXECUTE stmt_updated_at;
DEALLOCATE PREPARE stmt_updated_at;

SET @col_last_used := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'candidate_llm_api_keys' AND column_name = 'last_used_at'
);
SET @sql_last_used := IF(
  @col_last_used = 0,
  'ALTER TABLE candidate_llm_api_keys ADD COLUMN last_used_at TIMESTAMP NULL DEFAULT NULL',
  'SELECT 1'
);
PREPARE stmt_last_used FROM @sql_last_used;
EXECUTE stmt_last_used;
DEALLOCATE PREPARE stmt_last_used;

SET @col_voice := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'candidate_llm_api_keys' AND column_name = 'voice_enabled'
);
SET @sql_voice := IF(
  @col_voice = 0,
  'ALTER TABLE candidate_llm_api_keys ADD COLUMN voice_enabled BOOLEAN NOT NULL DEFAULT FALSE',
  'SELECT 1'
);
PREPARE stmt_voice FROM @sql_voice;
EXECUTE stmt_voice;
DEALLOCATE PREPARE stmt_voice;

SET @col_is_default := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'candidate_llm_api_keys' AND column_name = 'is_default'
);
SET @sql_is_default := IF(
  @col_is_default = 0,
  'ALTER TABLE candidate_llm_api_keys ADD COLUMN is_default BOOLEAN NOT NULL DEFAULT FALSE',
  'SELECT 1'
);
PREPARE stmt_is_default FROM @sql_is_default;
EXECUTE stmt_is_default;
DEALLOCATE PREPARE stmt_is_default;

SET @idx_provider := (
  SELECT COUNT(*) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'candidate_llm_api_keys'
    AND index_name = 'idx_candidate_llm_keys_candidate_provider'
);
SET @sql_idx := IF(
  @idx_provider = 0,
  'CREATE INDEX idx_candidate_llm_keys_candidate_provider ON candidate_llm_api_keys (candidate_id, provider_name)',
  'SELECT 1'
);
PREPARE stmt_idx FROM @sql_idx;
EXECUTE stmt_idx;
DEALLOCATE PREPARE stmt_idx;

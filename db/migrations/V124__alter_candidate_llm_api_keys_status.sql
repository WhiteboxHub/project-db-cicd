-- alter_candidate_llm_api_keys: add status and validation tracking columns to candidate_llm_api_keys
ALTER TABLE candidate_llm_api_keys
    ADD COLUMN status VARCHAR(50) NOT NULL DEFAULT 'inactive',
    ADD COLUMN failure_reason TEXT NULL,
    ADD COLUMN failure_code VARCHAR(100) NULL,
    ADD COLUMN last_validated_at TIMESTAMP NULL DEFAULT NULL;

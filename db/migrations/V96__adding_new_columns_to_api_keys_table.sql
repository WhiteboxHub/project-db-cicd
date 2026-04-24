ALTER TABLE candidate_api_keys ADD COLUMN voice_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE candidate_api_keys DROP COLUMN services_enabled;
ALTER TABLE candidate_api_keys DROP INDEX unique_candidate_provider;
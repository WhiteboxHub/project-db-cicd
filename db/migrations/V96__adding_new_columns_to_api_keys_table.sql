-- 1. Add voice_enabled column
ALTER TABLE candidate_api_keys 
ADD COLUMN IF NOT EXISTS voice_enabled BOOLEAN DEFAULT FALSE;

-- 2. Drop deprecated column
ALTER TABLE candidate_api_keys 
DROP COLUMN IF EXISTS services_enabled;

-- 3. Drop unique constraint to allow multiple providers
ALTER TABLE candidate_api_keys 
DROP INDEX IF EXISTS unique_candidate_provider;
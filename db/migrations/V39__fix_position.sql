-- Migration to add candidate_id to raw_position table
ALTER TABLE raw_position 
ADD COLUMN candidate_id INT DEFAULT NULL COMMENT 'ID from candidate_marketing table - tracks which candidate inbox this came from'
AFTER id;

-- Add index for performance when filtering by candidate
CREATE INDEX idx_candidate_id ON raw_position(candidate_id);

-- 1. Add the column
ALTER TABLE candidate_interview
  ADD COLUMN position_id BIGINT NULL
  COMMENT 'FK to position.id';

-- 2. Add index for performance 
CREATE INDEX idx_candidate_interview_position_id
  ON candidate_interview(position_id);

-- 3. Add foreign key constraint
ALTER TABLE candidate_interview
  ADD CONSTRAINT fk_candidate_interview_position
  FOREIGN KEY (position_id)
  REFERENCES position(id)
  ON DELETE SET NULL
  ON UPDATE CASCADE;


-- Create table if not exists

CREATE TABLE IF NOT EXISTS job_activity_log (
  id int NOT NULL AUTO_INCREMENT,
  job_type_id int NOT NULL,
  candidate_id int DEFAULT NULL,
  employee_id int DEFAULT NULL,
  activity_date date NOT NULL,
  activity_count int DEFAULT 0,
  notes text,
  lastmod_user_id int DEFAULT NULL,
  lastmod_date_time timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY job_id (job_type_id),
  KEY employee_id (employee_id),
  KEY fk_job_activity_candidate (candidate_id),
  KEY idx_job_activity_log_last_mod_user_id (lastmod_user_id),
  CONSTRAINT fk_job_activity_candidate FOREIGN KEY (candidate_id) REFERENCES candidate(id) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_job_activity_log_last_mod_user FOREIGN KEY (lastmod_user_id) REFERENCES employee(id) ON DELETE SET NULL,
  CONSTRAINT job_activity_log_ibfk_1 FOREIGN KEY (job_type_id) REFERENCES job_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT job_activity_log_ibfk_2 FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Add index for fast cleanup
CREATE INDEX IF NOT EXISTS idx_job_activity_log_activity_date
ON job_activity_log (activity_date);


-- Drop old cleanup event if any

DROP EVENT IF EXISTS ev_cleanup_job_activity_log;


-- Weekly cleanup event

CREATE EVENT ev_cleanup_job_activity_log
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP
DO
DELETE FROM job_activity_log
WHERE activity_date < CURDATE() - INTERVAL 7 DAY;

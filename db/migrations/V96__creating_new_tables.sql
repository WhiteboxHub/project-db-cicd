-- Recreate candidate_api_keys
CREATE TABLE candidate_api_keys (
  id INT NOT NULL AUTO_INCREMENT,
  candidate_id INT NOT NULL,
  provider_name VARCHAR(50) NOT NULL,
  api_key TEXT NOT NULL,
  model_name VARCHAR(100) DEFAULT NULL,
  voice_enabled BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_candidate_api_keys_candidate (candidate_id),
  CONSTRAINT fk_candidate_api_keys_candidate
    FOREIGN KEY (candidate_id)
    REFERENCES candidate (id)
    ON DELETE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- Recreate candidate_resume
CREATE TABLE candidate_resume (
  id INT NOT NULL AUTO_INCREMENT,
  candidate_id INT NOT NULL,
  resume_json JSON NOT NULL,
  file_name VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_candidate_resume_candidate (candidate_id),
  CONSTRAINT fk_candidate_resume_candidate
    FOREIGN KEY (candidate_id)
    REFERENCES candidate (id)
    ON DELETE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
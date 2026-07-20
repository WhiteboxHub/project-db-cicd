-- Ensure referenced tables exist for CI pipeline (blank DB test run)
CREATE TABLE IF NOT EXISTS recording (
  id INT NOT NULL AUTO_INCREMENT,
  description TEXT,
  type VARCHAR(50),
  classdate DATETIME NULL,
  link VARCHAR(1024),
  videoid VARCHAR(255),
  subject VARCHAR(255),
  filename VARCHAR(255),
  lastmoddatetime DATETIME,
  backup_url VARCHAR(400),
  new_subject_id INT,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS session (
  sessionid INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(500),
  status VARCHAR(45) NOT NULL,
  link VARCHAR(1024),
  videoid VARCHAR(255),
  backup_url VARCHAR(200),
  type VARCHAR(50),
  sessiondate DATETIME,
  lastmoddatetime DATETIME,
  subject_id INT NOT NULL DEFAULT 0,
  subject VARCHAR(45),
  notes VARCHAR(100),
  PRIMARY KEY (sessionid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create attendance bridge tables
CREATE TABLE candidate_classes (
  candidate_id INT NOT NULL,
  recording_id INT NOT NULL,
  PRIMARY KEY (candidate_id, recording_id),
  CONSTRAINT fk_candidate_classes_candidate
    FOREIGN KEY (candidate_id)
    REFERENCES candidate (id)
    ON DELETE CASCADE,
  CONSTRAINT fk_candidate_classes_recording
    FOREIGN KEY (recording_id)
    REFERENCES recording (id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE candidate_session (
  candidate_id INT NOT NULL,
  session_id INT NOT NULL,
  PRIMARY KEY (candidate_id, session_id),
  CONSTRAINT fk_candidate_session_candidate
    FOREIGN KEY (candidate_id)
    REFERENCES candidate (id)
    ON DELETE CASCADE,
  CONSTRAINT fk_candidate_session_session
    FOREIGN KEY (session_id)
    REFERENCES session (sessionid)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

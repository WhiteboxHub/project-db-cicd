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

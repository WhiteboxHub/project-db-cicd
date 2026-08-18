-- =====================================================================
-- AIPrep Tool — Complete DDL (14 tables)
-- Migration script V131: Creates all ai_prep_* tables for the AIPrep module
-- =====================================================================

-- 1. Question Bank
CREATE TABLE IF NOT EXISTS `ai_prep_question_bank` (
  `id`                   INT NOT NULL AUTO_INCREMENT,
  `category`             ENUM('TECHNICAL','SYSTEM_DESIGN','BEHAVIORAL',
                              'RECRUITER','HIRING_MANAGER','GENERAL') NOT NULL,
  `sub_category`         VARCHAR(100) NOT NULL,
  `difficulty_level`     ENUM('EASY','MEDIUM','HARD','EXPERT') NOT NULL DEFAULT 'MEDIUM',
  `question_text`        TEXT NOT NULL,
  `ideal_answer_rubric`  TEXT DEFAULT NULL,
  `relevant_skills_json` JSON DEFAULT NULL,
  `is_active`            TINYINT(1) NOT NULL DEFAULT 1,
  `created_at`           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_qb_category_diff` (`category`, `difficulty_level`),
  KEY `idx_qb_active`        (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2. Assessments
CREATE TABLE IF NOT EXISTS `ai_prep_assessments` (
  `id`                    INT NOT NULL AUTO_INCREMENT,
  `candidate_id`          INT NOT NULL,
  `candidate_resume_id`   INT DEFAULT NULL,
  `assessment_type`       ENUM('GENERAL_INTRO','JOB_DESCRIPTION_INTRO',
                               'RECRUITER','HIRING_MANAGER',
                               'TECHNICAL','SYSTEM_DESIGN','HR') NOT NULL,
  `assessment_mode`       ENUM('VIDEO_AUDIO','AUDIO_ONLY') NOT NULL DEFAULT 'VIDEO_AUDIO',
  `status`                ENUM('TESTING','IN_PROGRESS','PROCESSING',
                               'COMPLETED','FAILED') NOT NULL DEFAULT 'TESTING',
  `attempt_number`        INT NOT NULL DEFAULT 1,
  `job_description_text`  TEXT DEFAULT NULL,
  `started_at`            DATETIME DEFAULT NULL,
  `completed_at`          DATETIME DEFAULT NULL,
  `created_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ass_candidate`  (`candidate_id`),
  KEY `idx_ass_status`     (`status`),
  KEY `idx_ass_type`       (`assessment_type`),
  CONSTRAINT `fk_aiprep_ass_candidate`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidate` (`id`)
    ON DELETE RESTRICT,
  CONSTRAINT `fk_aiprep_ass_resume`
    FOREIGN KEY (`candidate_resume_id`)
    REFERENCES `candidate_resume` (`id`)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 3. Assessment Questions (join: assessment ↔ question bank)
CREATE TABLE IF NOT EXISTS `ai_prep_assessment_questions` (
  `id`                          INT NOT NULL AUTO_INCREMENT,
  `assessment_id`               INT NOT NULL,
  `question_id`                 INT NOT NULL,
  `order_index`                 INT NOT NULL DEFAULT 1,
  `candidate_answer_transcript` LONGTEXT DEFAULT NULL,
  `question_score`              INT DEFAULT NULL,
  `feedback_text`               TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aq_assessment` (`assessment_id`),
  KEY `idx_aq_question`   (`question_id`),
  CONSTRAINT `fk_aiprep_aq_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_aiprep_aq_question`
    FOREIGN KEY (`question_id`)
    REFERENCES `ai_prep_question_bank` (`id`)
    ON DELETE RESTRICT,
  CONSTRAINT `chk_aq_score`
    CHECK (`question_score` IS NULL OR
           (`question_score` >= 0 AND `question_score` <= 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 4. Hardware / Device Checks
CREATE TABLE IF NOT EXISTS `ai_prep_hardware_checks` (
  `id`                INT NOT NULL AUTO_INCREMENT,
  `assessment_id`     INT NOT NULL,
  `browser_info`      VARCHAR(255) DEFAULT NULL,
  `os_info`           VARCHAR(255) DEFAULT NULL,
  `camera_permission` TINYINT(1) NOT NULL DEFAULT 0,
  `mic_permission`    TINYINT(1) NOT NULL DEFAULT 0,
  `speaker_ok`        TINYINT(1) NOT NULL DEFAULT 0,
  `bandwidth_kbps`    INT NOT NULL DEFAULT 0,
  `yolo_model_enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `tested_at`         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_hw_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_hw_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 5. Media Files
CREATE TABLE IF NOT EXISTS `ai_prep_media_files` (
  `id`               INT NOT NULL AUTO_INCREMENT,
  `assessment_id`    INT NOT NULL,
  `audio_file_path`  VARCHAR(500) NOT NULL,
  `video_file_path`  VARCHAR(500) DEFAULT NULL,
  `duration_seconds` INT NOT NULL DEFAULT 0,
  `file_size_bytes`  BIGINT NOT NULL DEFAULT 0,
  `created_at`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_media_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_media_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 6. Transcripts
CREATE TABLE IF NOT EXISTS `ai_prep_transcripts` (
  `id`                   INT NOT NULL AUTO_INCREMENT,
  `assessment_id`        INT NOT NULL,
  `transcript_text`      LONGTEXT NOT NULL,
  `word_timestamps_json` JSON DEFAULT NULL,
  `created_at`           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tx_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_tx_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 7. Vision Telemetry (browser-side YOLO — consent-gated)
CREATE TABLE IF NOT EXISTS `ai_prep_vision_telemetry` (
  `id`                   INT NOT NULL AUTO_INCREMENT,
  `assessment_id`        INT NOT NULL,
  `face_visible_pct`     DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  `head_nods_count`      INT NOT NULL DEFAULT 0,
  `frame_stability_score` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  `snapshots_json`       JSON DEFAULT NULL,
  `created_at`           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_vision_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_vision_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `chk_vision_face_pct`
    CHECK (`face_visible_pct` >= 0.00 AND `face_visible_pct` <= 100.00),
  CONSTRAINT `chk_vision_stability`
    CHECK (`frame_stability_score` >= 0.00 AND `frame_stability_score` <= 100.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 8. Audio Telemetry
CREATE TABLE IF NOT EXISTS `ai_prep_audio_telemetry` (
  `id`                    INT NOT NULL AUTO_INCREMENT,
  `assessment_id`         INT NOT NULL,
  `avg_volume_db`         DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  `background_noise_level` ENUM('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'LOW',
  `clipping_detected`     TINYINT(1) NOT NULL DEFAULT 0,
  `silence_ratio_pct`     DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  `filler_words_per_min`  INT NOT NULL DEFAULT 0,
  `speaking_pace_wpm`     INT NOT NULL DEFAULT 0,
  `created_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_audio_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_audio_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `chk_audio_silence`
    CHECK (`silence_ratio_pct` >= 0.00 AND `silence_ratio_pct` <= 100.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 9. Reports
CREATE TABLE IF NOT EXISTS `ai_prep_reports` (
  `id`                        INT NOT NULL AUTO_INCREMENT,
  `assessment_id`             INT NOT NULL,
  `overall_score`             INT NOT NULL,
  `coaching_band`             ENUM('EXCELLENT','STRONG','DEVELOPING','NEEDS_WORK') NOT NULL,
  `formula_explanation`       VARCHAR(255) DEFAULT '(AI_Eng*0.40)+(Core_Eng*0.30)+(Non_Tech*0.20)+(Biz*0.10)',
  `scores_breakdown_json`     JSON NOT NULL,
  `technical_analysis_json`   JSON NOT NULL,
  `non_technical_analysis_json` JSON NOT NULL,
  `coaching_suggestions_json` JSON DEFAULT NULL,
  `signal_timeline_json`      JSON DEFAULT NULL,
  `transcript_evidence_json`  JSON DEFAULT NULL,
  `gaps_to_validate_json`     JSON DEFAULT NULL,
  `improvements_json`         JSON DEFAULT NULL,
  `raw_llm_response_path`     VARCHAR(500) DEFAULT NULL,
  `created_at`                DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_report_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_rep_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `chk_rep_score`
    CHECK (`overall_score` >= 0 AND `overall_score` <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 10. Consents
CREATE TABLE IF NOT EXISTS `ai_prep_consents` (
  `id`           INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `consent_type` ENUM('VIDEO_ANALYTICS','DATA_RETENTION','TERMS_OF_SERVICE') NOT NULL,
  `consented`    TINYINT(1) NOT NULL DEFAULT 0,
  `ip_address`   VARCHAR(45) DEFAULT NULL,
  `user_agent`   VARCHAR(500) DEFAULT NULL,
  `consented_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `revoked_at`   DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_consent_candidate_type` (`candidate_id`, `consent_type`),
  CONSTRAINT `fk_aiprep_consent_candidate`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidate` (`id`)
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 11. Share Grants
CREATE TABLE IF NOT EXISTS `ai_prep_share_grants` (
  `id`                     INT NOT NULL AUTO_INCREMENT,
  `assessment_id`          INT NOT NULL,
  `shared_by_candidate_id` INT NOT NULL,
  `share_token`            VARCHAR(64) NOT NULL,
  `expires_at`             DATETIME NOT NULL,
  `created_at`             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_share_token` (`share_token`),
  KEY `idx_share_assessment` (`assessment_id`),
  CONSTRAINT `fk_aiprep_share_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 12. Deletion Requests
CREATE TABLE IF NOT EXISTS `ai_prep_deletion_requests` (
  `id`           INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `requested_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` DATETIME DEFAULT NULL,
  `status`       ENUM('PENDING','IN_PROGRESS','COMPLETED','FAILED') NOT NULL DEFAULT 'PENDING',
  `notes`        TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_del_candidate` (`candidate_id`),
  CONSTRAINT `fk_aiprep_del_candidate`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidate` (`id`)
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 13. Audit Events
CREATE TABLE IF NOT EXISTS `ai_prep_audit_events` (
  `id`            BIGINT NOT NULL AUTO_INCREMENT,
  `candidate_id`  INT DEFAULT NULL,
  `assessment_id` INT DEFAULT NULL,
  `event_type`    VARCHAR(100) NOT NULL,
  `actor_id`      INT DEFAULT NULL,
  `actor_role`    VARCHAR(50) DEFAULT NULL,
  `details_json`  JSON DEFAULT NULL,
  `ip_address`    VARCHAR(45) DEFAULT NULL,
  `created_at`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_audit_candidate`   (`candidate_id`),
  KEY `idx_audit_assessment`  (`assessment_id`),
  KEY `idx_audit_event_type`  (`event_type`),
  KEY `idx_audit_created`     (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 14. Analysis Runs
CREATE TABLE IF NOT EXISTS `ai_prep_analysis_runs` (
  `id`              INT NOT NULL AUTO_INCREMENT,
  `assessment_id`   INT NOT NULL,
  `run_type`        ENUM('STT','AUDIO','VISION','LLM','FULL') NOT NULL,
  `status`          ENUM('QUEUED','RUNNING','COMPLETED','FAILED') NOT NULL DEFAULT 'QUEUED',
  `started_at`      DATETIME DEFAULT NULL,
  `completed_at`    DATETIME DEFAULT NULL,
  `error_message`   TEXT DEFAULT NULL,
  `celery_task_id`  VARCHAR(255) DEFAULT NULL,
  `created_at`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_run_assessment` (`assessment_id`),
  KEY `idx_run_status`     (`status`),
  CONSTRAINT `fk_aiprep_run_assessment`
    FOREIGN KEY (`assessment_id`)
    REFERENCES `ai_prep_assessments` (`id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- AI PREP DATABASE SCHEMA
-- Migration: V134
-- Creates 4 new simplified AI Prep tables

CREATE TABLE IF NOT EXISTS `ai_prep_question_bank` (
    `id` INT NOT NULL AUTO_INCREMENT,

    `category` ENUM(
        'INTRO',
        'JD_INTRO',
        'RECRUITER',
        'HIRING_MANAGER',
        'SYSTEM_DESIGN',
        'TECHNICAL'
    ) NOT NULL,

    `sub_category` VARCHAR(100) NULL,

    `difficulty_level` ENUM(
        'EASY',
        'MEDIUM',
        'HARD',
        'EXPERT'
    ) NOT NULL DEFAULT 'MEDIUM',

    `question_text` TEXT NOT NULL,

    `is_active` TINYINT(1) NOT NULL DEFAULT 1,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_qb_category` (
        `category`
    ),

    INDEX `idx_qb_category_subcategory` (
        `category`,
        `sub_category`
    ),

    INDEX `idx_qb_category_difficulty` (
        `category`,
        `difficulty_level`
    ),

    INDEX `idx_qb_active` (
        `is_active`
    ),

    CONSTRAINT `chk_qb_subcategory`
    CHECK (
        (`category` = 'TECHNICAL' AND `sub_category` IS NOT NULL)
        OR
        (`category` <> 'TECHNICAL' AND `sub_category` IS NULL)
    )

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE IF NOT EXISTS `ai_prep_assessment` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `candidate_id` BIGINT NOT NULL,

    `assessment_type` ENUM(
        'INTRO',
        'JD_INTRO',
        'RECRUITER',
        'HIRING_MANAGER',
        'SYSTEM_DESIGN',
        'TECHNICAL'
    ) NOT NULL,

    `media_type` ENUM(
        'AUDIO',
        'VIDEO'
    ) NOT NULL,

    `status` ENUM(
        'IN_PROGRESS',
        'EVALUATING',
        'COMPLETED',
        'FAILED'
    ) NOT NULL DEFAULT 'IN_PROGRESS',

    `job_description` TEXT NULL,

    `ip_address` VARCHAR(45) NULL,

    `user_agent` TEXT NULL,

    `started_at` DATETIME NULL,

    `completed_at` DATETIME NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    `youtube_url` TEXT NULL,

    PRIMARY KEY (`id`),

    INDEX `idx_assessment_candidate` (
        `candidate_id`
    ),

    INDEX `idx_assessment_type` (
        `assessment_type`
    ),

    INDEX `idx_assessment_status` (
        `status`
    )

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `ai_prep_assessment_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `assessment_id` BIGINT NOT NULL,

    `questions` JSON NULL,

    `transcript` JSON NULL,

    `audio_telemetry` JSON NULL,

    `video_telemetry` JSON NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    UNIQUE KEY `uq_assessment_data` (
        `assessment_id`
    ),

    CONSTRAINT `fk_assessment_data_assessment`
        FOREIGN KEY (`assessment_id`)
        REFERENCES `ai_prep_assessment` (`id`)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `ai_prep_assessment_report` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `assessment_id` BIGINT NOT NULL,

    `audio_evaluation` JSON NULL,

    `video_evaluation` JSON NULL,

    `transcript_evaluation` JSON NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    UNIQUE KEY `uq_assessment_report` (
        `assessment_id`
    ),

    CONSTRAINT `fk_assessment_report_assessment`
        FOREIGN KEY (`assessment_id`)
        REFERENCES `ai_prep_assessment` (`id`)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




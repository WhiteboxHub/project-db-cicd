CREATE TABLE IF NOT EXISTS `jobcli_field_answers` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `ats_type` VARCHAR(100) NOT NULL,
    `normalized_label` VARCHAR(255) NOT NULL,
    `value` VARCHAR(500) NOT NULL,
    `total_success` INT NOT NULL DEFAULT 0,
    `total_failure` INT NOT NULL DEFAULT 0,
    `confidence` DECIMAL(5,4) NOT NULL DEFAULT 0.0000,
    `version`  VARCHAR(50) DEFAULT 'v1.0.0',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `uk_ats_label` (`ats_type`, `normalized_label`, `value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `jobcli_locators` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `ats_type` VARCHAR(100) NOT NULL,
    `purpose` VARCHAR(100) NOT NULL,
    `selector` TEXT NOT NULL,
    `selector_type` VARCHAR(50) DEFAULT 'css',
    `domain_pattern` VARCHAR(255) DEFAULT NULL,
    `total_success` INT NOT NULL DEFAULT 0,
    `total_failure` INT NOT NULL DEFAULT 0,
    `confidence` FLOAT NOT NULL DEFAULT 0.0,
    `version` VARCHAR(50) NOT NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `uk_ats_purpose_selector` (`ats_type`, `purpose`, `selector`(255)),
    INDEX `idx_ats_purpose` (`ats_type`, `purpose`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `jobcli_sync_versions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `version` VARCHAR(50) NOT NULL UNIQUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `notes` TEXT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert initial version
INSERT IGNORE INTO `jobcli_sync_versions` (`version`, `notes`) VALUES ('v1.0.0', 'Initial sync version');

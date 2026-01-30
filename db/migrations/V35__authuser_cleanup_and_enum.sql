-- AUTHUSER: Backup + Clean + Validate + Alter
-- Production Safe Migration

-- Ensure table exists (for CI environment)

CREATE TABLE IF NOT EXISTS `authuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uname` varchar(50) NOT NULL DEFAULT '',
  `passwd` varchar(32) NOT NULL,
  `team` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `logincount` int DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `message` text,
  `registereddate` datetime DEFAULT NULL,
  `level3date` datetime DEFAULT NULL,
  `lastmoddatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `demo` char(1) NOT NULL DEFAULT 'N',
  `enddate` date NOT NULL DEFAULT '1990-01-01',
  `googleId` varchar(255) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `visa_status` varchar(50) DEFAULT NULL,
  `notes` text,
  `role` varchar(100) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `refresh_token_expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authuser_unique` (`uname`),
  UNIQUE KEY `uname_unique` (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- Clean Invalid Timestamps

UPDATE authuser
SET lastlogin = NULL
WHERE lastlogin < '1000-01-01 00:00:00';

UPDATE authuser
SET level3date = NULL
WHERE level3date < '1000-01-01 00:00:00';

UPDATE authuser
SET registereddate = NULL
WHERE registereddate < '1000-01-01 00:00:00';

UPDATE authuser
SET token_expiry = NULL
WHERE token_expiry < '1000-01-01 00:00:00';

UPDATE authuser
SET refresh_token_expiry = NULL
WHERE refresh_token_expiry < '1000-01-01 00:00:00'

-- Create FULL Backup (Schema + Data)

DROP TABLE IF EXISTS authuser_backup;

CREATE TABLE authuser_backup LIKE authuser;

INSERT INTO authuser_backup
SELECT * FROM authuser;

SELECT 'Backup created: authuser_backup' AS status;


-- Normalize visa_status

-- Trim + Uppercase
UPDATE authuser
SET visa_status = UPPER(TRIM(visa_status))
WHERE visa_status IS NOT NULL;

-- Standardize values
UPDATE authuser
SET visa_status = 'US_CITIZEN'
WHERE visa_status IN ('CITIZEN','US CITIZEN','USC');

UPDATE authuser
SET visa_status = 'GREEN_CARD'
WHERE visa_status IN ('GREEN CARD','PERMANENT RESIDENT');

UPDATE authuser
SET visa_status = 'GC_EAD'
WHERE visa_status = 'EAD';

UPDATE authuser
SET visa_status = 'F1_OPT'
WHERE visa_status = 'OPT';

UPDATE authuser
SET visa_status = 'H4'
WHERE visa_status = 'H4';

-- Remove junk values
UPDATE authuser
SET visa_status = NULL
WHERE visa_status IN ('WAITING FOR STATUS','OTHER','VISA');

-- Remove empty / whitespace
UPDATE authuser
SET visa_status = NULL
WHERE TRIM(COALESCE(visa_status,'')) = '';



--  Validate Before ENUM
-- (If this returns >0 → STOP migration)


SELECT COUNT(*) AS invalid_visa_values
FROM authuser
WHERE visa_status IS NOT NULL
AND visa_status NOT IN (
  'US_CITIZEN','GREEN_CARD','GC_EAD','I485_EAD','I140_APPROVED',
  'F1','F1_OPT','F1_CPT',
  'J1','J1_AT',
  'H1B','H1B_TRANSFER','H1B_CAP_EXEMPT',
  'H4','H4_EAD',
  'L1A','L1B','L2','L2_EAD',
  'O1','TN',
  'E3','E3_EAD',
  'E2','E2_EAD',
  'TPS_EAD','ASYLUM_EAD','REFUGEE_EAD','DACA_EAD'
);


-- Convert Column to ENUM


ALTER TABLE authuser
MODIFY COLUMN visa_status ENUM(
  'US_CITIZEN','GREEN_CARD','GC_EAD','I485_EAD','I140_APPROVED',
  'F1','F1_OPT','F1_CPT',
  'J1','J1_AT',
  'H1B','H1B_TRANSFER','H1B_CAP_EXEMPT',
  'H4','H4_EAD',
  'L1A','L1B','L2','L2_EAD',
  'O1','TN',
  'E3','E3_EAD',
  'E2','E2_EAD',
  'TPS_EAD','ASYLUM_EAD','REFUGEE_EAD','DACA_EAD'
) DEFAULT NULL
COMMENT 'Visa / Immigration Status';



--  Post-Migration Verification


-- Row count check
SELECT 
  'Row count verification' AS check_name,
  (SELECT COUNT(*) FROM authuser) AS live_rows,
  (SELECT COUNT(*) FROM authuser_backup) AS backup_rows,
  CASE 
    WHEN (SELECT COUNT(*) FROM authuser) = (SELECT COUNT(*) FROM authuser_backup) 
    THEN 'MATCH' 
    ELSE 'MISMATCH' 
  END AS result;

-- Visa distribution
SELECT 
  'Visa status distribution' AS summary,
  visa_status, 
  COUNT(*) AS total
FROM authuser
WHERE visa_status IS NOT NULL
GROUP BY visa_status
ORDER BY total DESC;

-- Timestamp validation
SELECT
  'Timestamp validation' AS check_name,
  COUNT(CASE WHEN lastlogin < '1000-01-01' THEN 1 END) AS bad_lastlogin,
  COUNT(CASE WHEN level3date < '1000-01-01' THEN 1 END) AS bad_level3date,
  COUNT(CASE WHEN registereddate < '1000-01-01' THEN 1 END) AS bad_registereddate
FROM authuser;

-- Final success marker
SELECT 'V33 authuser migration completed successfully' AS status;
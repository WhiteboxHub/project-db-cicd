-- Clean up visa_status and timestamps, alter ENUM safely
-- Production-safe migration for Flyway


--Data cleanup: normalize visa_status
UPDATE `authuser`
SET visa_status = UPPER(visa_status)
WHERE id > 0;

UPDATE `authuser`
SET visa_status = 'US_CITIZEN'
WHERE visa_status IN ('CITIZEN','US CITIZEN','USC')
  AND id > 0;

UPDATE `authuser`
SET visa_status = 'GREEN_CARD'
WHERE visa_status IN ('GREEN CARD','PERMANENT RESIDENT')
  AND id > 0;

UPDATE `authuser`
SET visa_status = 'GC_EAD'
WHERE visa_status = 'EAD'
  AND id > 0;

UPDATE `authuser`
SET visa_status = 'F1_OPT'
WHERE visa_status = 'OPT'
  AND id > 0;

UPDATE `authuser`
SET visa_status = 'H4'
WHERE visa_status = 'H4'
  AND id > 0;

UPDATE `authuser`
SET visa_status = NULL
WHERE visa_status IN ('WAITING FOR STATUS','OTHER','VISA')
  AND id > 0;

-- Clean invalid timestamps
UPDATE `authuser`
SET lastlogin = NULL
WHERE id IN (
    SELECT id FROM (SELECT id FROM authuser WHERE lastlogin < '1000-01-01 00:00:00') AS t
);

UPDATE `authuser`
SET level3date = NULL
WHERE id IN (
    SELECT id FROM (SELECT id FROM authuser WHERE level3date < '1000-01-01 00:00:00') AS t
);

UPDATE `authuser`
SET registereddate = NULL
WHERE id IN (
    SELECT id FROM (SELECT id FROM authuser WHERE registereddate < '1000-01-01 00:00:00') AS t
);

UPDATE `authuser`
SET token_expiry = NULL
WHERE id IN (
    SELECT id FROM (SELECT id FROM authuser WHERE token_expiry < '1000-01-01 00:00:00') AS t
);

UPDATE `authuser`
SET refresh_token_expiry = NULL
WHERE id IN (
    SELECT id FROM (SELECT id FROM authuser WHERE refresh_token_expiry < '1000-01-01 00:00:00') AS t
);

-- Create a clean backup table
CREATE TABLE authuser_backup AS
SELECT 
    id,
    uname,
    passwd,
    team,
    status,
    CASE WHEN lastlogin < '1000-01-01 00:00:00' THEN NULL ELSE lastlogin END AS lastlogin,
    logincount,
    fullname,
    address,
    phone,
    state,
    zip,
    city,
    country,
    message,
    CASE WHEN registereddate < '1000-01-01 00:00:00' THEN NULL ELSE registereddate END AS registereddate,
    CASE WHEN level3date < '1000-01-01 00:00:00' THEN NULL ELSE level3date END AS level3date,
    CASE WHEN lastmoddatetime < '1000-01-01 00:00:00' THEN CURRENT_TIMESTAMP ELSE lastmoddatetime END AS lastmoddatetime,
    demo,
    enddate,
    googleId,
    reset_token,
    CASE WHEN token_expiry < '1000-01-01 00:00:00' THEN NULL ELSE token_expiry END AS token_expiry,
    CASE WHEN visa_status = '' OR visa_status = ' ' THEN NULL ELSE visa_status END AS visa_status,
    notes,
    role,
    refresh_token,
    CASE WHEN refresh_token_expiry < '1000-01-01 00:00:00' THEN NULL ELSE refresh_token_expiry END AS refresh_token_expiry
FROM authuser;

-- Alter ENUM in backup table
ALTER TABLE authuser_backup
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
) DEFAULT NULL;

--swap (rename tables)
RENAME TABLE authuser TO authuser_old,
             authuser_backup TO authuser;


SELECT DISTINCT visa_status FROM authuser;

-- CANDIDATE: Workstatus Cleanup + ENUM Conversion

--  Audit current workstatus values
SELECT DISTINCT workstatus
FROM candidate;

-- Normalize text to uppercase
UPDATE candidate
SET workstatus = UPPER(workstatus)
WHERE id > 0;

-- Map variations to canonical ENUM values
UPDATE candidate
SET workstatus = 'US_CITIZEN'
WHERE workstatus IN ('CITIZEN','US CITIZEN','USC')
  AND id > 0;

UPDATE candidate
SET workstatus = 'GREEN_CARD'
WHERE workstatus IN ('GREEN CARD','PERMANENT RESIDENT')
  AND id > 0;

UPDATE candidate
SET workstatus = 'GC_EAD'
WHERE workstatus = 'EAD'
  AND id > 0;

UPDATE candidate
SET workstatus = 'F1_OPT'
WHERE workstatus = 'OPT'
  AND id > 0;

UPDATE candidate
SET workstatus = 'H4'
WHERE workstatus = 'H4'
  AND id > 0;

UPDATE candidate
SET workstatus = NULL
WHERE workstatus IN ('WAITING FOR STATUS','VISA')
  AND id > 0;

-- Log any remaining invalid workstatus values
SELECT DISTINCT workstatus
FROM candidate
WHERE workstatus IS NOT NULL
  AND workstatus NOT IN (
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

-- Clean empty workstatus (Safe Update Mode compatible)
UPDATE candidate
SET workstatus = NULL
WHERE id IN (
  SELECT id FROM (
    SELECT id
    FROM candidate
    WHERE workstatus IN ('', ' ')
  ) t
);

-- audit counts
SELECT
  SUM(workstatus IS NULL) AS null_count,
  SUM(TRIM(workstatus) = '') AS empty_count
FROM candidate;

-- Convert column to ENUM (default NULL)
ALTER TABLE candidate
MODIFY COLUMN workstatus ENUM(
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

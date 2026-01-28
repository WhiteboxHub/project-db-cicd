-- LEAD: Workstatus Cleanup + ENUM Conversion

-- Audit any invalid workstatus values
SELECT DISTINCT workstatus
FROM `lead`
WHERE workstatus IS NOT NULL
  AND workstatus NOT IN (
    'US_CITIZEN','GREEN_CARD','GC_EAD','I485_EAD','I140_APPROVED',
    'F1','F1_OPT','F1_CPT',
    'J1','J1_AT',
    'H1B','H1B_TRANSFER','H1B_CAP_EXEMPT',
    'H4','H4_EAD',
    'L1A','L1B','L2','L2_EAD',
    'O1','TN',
    'E3','E3_EAD','E2','E2_EAD',
    'TPS_EAD','ASYLUM_EAD','REFUGEE_EAD','DACA_EAD'
  );

-- Normalize text to uppercase
UPDATE `lead`
SET workstatus = UPPER(workstatus)
WHERE id > 0;

-- Map variations to canonical ENUM values
UPDATE `lead`
SET workstatus = 'US_CITIZEN'
WHERE workstatus IN ('CITIZEN','US CITIZEN','USC')
  AND id > 0;

UPDATE `lead`
SET workstatus = 'GREEN_CARD'
WHERE workstatus IN ('GREEN CARD','PERMANENT RESIDENT')
  AND id > 0;

UPDATE `lead`
SET workstatus = 'GC_EAD'
WHERE workstatus IN ('GC','GC EAD','EAD')
  AND id > 0;

UPDATE `lead`
SET workstatus = 'F1_OPT'
WHERE workstatus = 'OPT'
  AND id > 0;

UPDATE `lead`
SET workstatus = 'H4'
WHERE workstatus IN ('H4','H4 (WAITING FOR EAD)')
  AND id > 0;

UPDATE `lead`
SET workstatus = 'H4_EAD'
WHERE workstatus IN ('H4EAD','H4 EAD')
  AND id > 0;

UPDATE `lead`
SET workstatus = 'L1A'
WHERE workstatus = 'L1'
  AND id > 0;

UPDATE `lead`
SET workstatus = 'L2'
WHERE workstatus = 'L2'
  AND id > 0;

UPDATE `lead`
SET workstatus = NULL
WHERE workstatus IN (
  'WAITING',
  'WAITING FOR STATUS',
  'VISA',
  'OTHER',
  'NON-US',
  'INDIA'
)
AND id > 0;

-- Audit remaining workstatus
SELECT DISTINCT workstatus FROM `lead`;

-- Clean empty workstatus (Safe Update Mode compatible)
SELECT COUNT(*) FROM `lead`
WHERE workstatus = '' OR workstatus = ' ';

UPDATE `lead`
SET workstatus = NULL
WHERE id IN (
  SELECT id FROM (
    SELECT id
    FROM `lead`
    WHERE workstatus = '' OR workstatus = ' '
  ) t
);

-- Fix invalid closed_date
SELECT COUNT(*)
FROM `lead`
WHERE closed_date IS NOT NULL
  AND closed_date < '1000-01-01';

UPDATE `lead`
SET closed_date = NULL
WHERE id IN (
  SELECT id FROM (
    SELECT id
    FROM `lead`
    WHERE closed_date IS NOT NULL
      AND closed_date < '1000-01-01'
  ) x
);

-- Convert workstatus column to ENUM
ALTER TABLE `lead`
MODIFY COLUMN workstatus ENUM(
  'US_CITIZEN','GREEN_CARD','GC_EAD','I485_EAD','I140_APPROVED',
  'F1','F1_OPT','F1_CPT',
  'J1','J1_AT',
  'H1B','H1B_TRANSFER','H1B_CAP_EXEMPT',
  'H4','H4_EAD',
  'L1A','L1B','L2','L2_EAD',
  'O1','TN',
  'E3','E3_EAD','E2','E2_EAD',
  'TPS_EAD','ASYLUM_EAD','REFUGEE_EAD','DACA_EAD'
) DEFAULT NULL;

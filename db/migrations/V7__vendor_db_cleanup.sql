-- Check for duplicates/noise ------------
SELECT *
FROM vendor
WHERE email IN (
    SELECT email
    FROM vendor
    GROUP BY email
    HAVING COUNT(*) > 1
)

------ preview which row to kept or remove by high-value data fields-----------
-- For every email that appears more than once, this query checks how much actual information each row has.
-- The row with more filled-in details (name, phone, company, LinkedIn, location, activity flags) is considered better.
-- Rows are shown grouped by email, with the best one listed first.
-- This is only a preview so we can clearly see which record to keep before deleting the others.


SELECT *,
(
    (full_name IS NOT NULL AND full_name <> '') +
    (phone_number IS NOT NULL AND phone_number <> '') +
    (secondary_phone IS NOT NULL AND secondary_phone <> '') +
    (company_name IS NOT NULL AND company_name <> '') +
    (linkedin_id IS NOT NULL AND linkedin_id <> '') +
    (linkedin_internal_id IS NOT NULL AND linkedin_internal_id <> '') +
    (address IS NOT NULL AND address <> '') +
    (city IS NOT NULL AND city <> '') +
    (location IS NOT NULL AND location <> '') +
    (country IS NOT NULL AND country <> '') +
    (postal_code IS NOT NULL AND postal_code <> '') +
    (notes IS NOT NULL AND notes <> '') +
    (linkedin_connected = 'YES') +
    (intro_email_sent = 'YES') +
    (intro_call = 'YES')
) AS data_score
FROM vendor
WHERE email IN (
    SELECT email
    FROM vendor
    GROUP BY email
    HAVING COUNT(*) > 1
)
ORDER BY email, data_score DESC, created_at DESC;

-- For every email that appears more than once in vendor table -------------
--1. All rows with the same email are ranked -------------------
--2. The highest-quality row is kept----------------------------
--3. All other rows for that email are deleted------------------


DELETE v
FROM vendor v
JOIN (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (
                   PARTITION BY email
                   ORDER BY
                     (
                       (full_name IS NOT NULL AND full_name <> '') +
                       (phone_number IS NOT NULL AND phone_number <> '') +
                       (secondary_phone IS NOT NULL AND secondary_phone <> '') +
                       (company_name IS NOT NULL AND company_name <> '') +
                       (linkedin_id IS NOT NULL AND linkedin_id <> '') +
                       (linkedin_internal_id IS NOT NULL AND linkedin_internal_id <> '') +
                       (address IS NOT NULL AND address <> '') +
                       (city IS NOT NULL AND city <> '') +
                       (location IS NOT NULL AND location <> '') +
                       (country IS NOT NULL AND country <> '') +
                       (postal_code IS NOT NULL AND postal_code <> '') +
                       (notes IS NOT NULL AND notes <> '') +
                       (linkedin_connected = 'YES') +
                       (intro_email_sent = 'YES') +
                       (intro_call = 'YES')
                     ) DESC,
                     created_at DESC
               ) AS rn
        FROM vendor
    ) ranked
    WHERE rn > 1
) d ON v.id = d.id;

-- Check for duplicates/noise
SELECT *
FROM vendor
WHERE email IN (
    SELECT email
    FROM vendor
    GROUP BY email
    HAVING COUNT(*) > 1
)

-- preview which row to kept or remove by high-value data fields
-- For every email that appears more than once, this query checks how much actual information each row has.
-- The row with more filled-in details (name, phone, company, LinkedIn, location, activity flags) is considered better.
-- Rows are shown grouped by email, with the best one listed first.
-- This is only a preview so we can clearly see which record to keep before deleting the others.


SELECT
    v.*,
    (
        CASE WHEN full_name IS NOT NULL AND full_name <> '' THEN 1 ELSE 0 END +
        CASE WHEN phone_number IS NOT NULL AND phone_number <> '' THEN 1 ELSE 0 END +
        CASE WHEN secondary_phone IS NOT NULL AND secondary_phone <> '' THEN 1 ELSE 0 END +
        CASE WHEN company_name IS NOT NULL AND company_name <> '' THEN 1 ELSE 0 END +
        CASE WHEN linkedin_id IS NOT NULL AND linkedin_id <> '' THEN 1 ELSE 0 END +
        CASE WHEN linkedin_internal_id IS NOT NULL AND linkedin_internal_id <> '' THEN 1 ELSE 0 END +
        CASE WHEN address IS NOT NULL AND address <> '' THEN 1 ELSE 0 END +
        CASE WHEN city IS NOT NULL AND city <> '' THEN 1 ELSE 0 END +
        CASE WHEN location IS NOT NULL AND location <> '' THEN 1 ELSE 0 END +
        CASE WHEN country IS NOT NULL AND country <> '' THEN 1 ELSE 0 END +
        CASE WHEN postal_code IS NOT NULL AND postal_code <> '' THEN 1 ELSE 0 END +
        CASE WHEN notes IS NOT NULL AND notes <> '' THEN 1 ELSE 0 END +
        CASE WHEN linkedin_connected = 'YES' THEN 1 ELSE 0 END +
        CASE WHEN intro_email_sent = 'YES' THEN 1 ELSE 0 END +
        CASE WHEN intro_call = 'YES' THEN 1 ELSE 0 END
    ) AS data_score
FROM vendor v
WHERE email IN (
    SELECT email
    FROM vendor
    GROUP BY email
    HAVING COUNT(*) > 1
)
ORDER BY email, data_score DESC, created_at DESC;


-- For every email that appears more than once in vendor table
--1. All rows with the same email are ranked
--2. The highest-quality row is kept
--3. All other rows for that email are deleted


DELETE v
FROM vendor v
JOIN (
    SELECT id
    FROM (
        SELECT
            id,
            ROW_NUMBER() OVER (
                PARTITION BY email
                ORDER BY
                    (
                        CASE WHEN full_name IS NOT NULL AND full_name <> '' THEN 1 ELSE 0 END +
                        CASE WHEN phone_number IS NOT NULL AND phone_number <> '' THEN 1 ELSE 0 END +
                        CASE WHEN secondary_phone IS NOT NULL AND secondary_phone <> '' THEN 1 ELSE 0 END +
                        CASE WHEN company_name IS NOT NULL AND company_name <> '' THEN 1 ELSE 0 END +
                        CASE WHEN linkedin_id IS NOT NULL AND linkedin_id <> '' THEN 1 ELSE 0 END +
                        CASE WHEN linkedin_internal_id IS NOT NULL AND linkedin_internal_id <> '' THEN 1 ELSE 0 END +
                        CASE WHEN address IS NOT NULL AND address <> '' THEN 1 ELSE 0 END +
                        CASE WHEN city IS NOT NULL AND city <> '' THEN 1 ELSE 0 END +
                        CASE WHEN location IS NOT NULL AND location <> '' THEN 1 ELSE 0 END +
                        CASE WHEN country IS NOT NULL AND country <> '' THEN 1 ELSE 0 END +
                        CASE WHEN postal_code IS NOT NULL AND postal_code <> '' THEN 1 ELSE 0 END +
                        CASE WHEN notes IS NOT NULL AND notes <> '' THEN 1 ELSE 0 END +
                        CASE WHEN linkedin_connected = 'YES' THEN 1 ELSE 0 END +
                        CASE WHEN intro_email_sent = 'YES' THEN 1 ELSE 0 END +
                        CASE WHEN intro_call = 'YES' THEN 1 ELSE 0 END
                    ) DESC,
                    created_at DESC
            ) AS rn
        FROM vendor
    ) ranked
    WHERE rn > 1
) d ON v.id = d.id;

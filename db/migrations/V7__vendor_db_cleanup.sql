-- Delete lower-quality duplicate vendor rows
-- Only run if vendor table exists

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
) d ON v.id = d.id
WHERE EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_schema = DATABASE()
      AND table_name = 'vendor'
);

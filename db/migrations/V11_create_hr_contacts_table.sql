CREATE TABLE IF NOT EXISTS company_hr_contacts (
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    company_name VARCHAR(255),
    location VARCHAR(500),
    job_title VARCHAR(255),
    is_immigration_team BOOLEAN,
    extraction_date TIMESTAMP
);


CREATE TABLE potential_leads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30),
    profession VARCHAR(150),
    linkedin_id VARCHAR(255),
    internal_linkedin_id VARCHAR(255),
    entry_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    work_status VARCHAR(50),
    location VARCHAR(150),
    notes TEXT,
    lastmoddatetime DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_potential_leads_email UNIQUE (email),
    CONSTRAINT uk_potential_leads_linkedin UNIQUE (linkedin_id)
);

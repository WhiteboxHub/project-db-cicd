-- Create vendor_contact_extracts table if it doesn't exist
CREATE TABLE IF NOT EXISTS vendor_contact_extracts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    source_email VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(50),
    linkedin_id VARCHAR(255),
    company_name VARCHAR(255),
    location VARCHAR(255),
    extraction_date DATE,
    moved_to_vendor TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    linkedin_internal_id VARCHAR(255)
);

-- Create vendor table if it doesn't exist
CREATE TABLE IF NOT EXISTS vendor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    phone_number VARCHAR(50),
    secondary_phone VARCHAR(50),
    email VARCHAR(255),
    type ENUM('client', 'third-party-vendor', 'implementation-partner', 'sourcer', 'contact-from-ip') NOT NULL DEFAULT 'client',
    notes VARCHAR(255),
    linkedin_id VARCHAR(255),
    company_name VARCHAR(255),
    location VARCHAR(255),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    address TEXT,
    country VARCHAR(50),
    status ENUM('active', 'working', 'not_useful', 'do_not_contact', 'inactive', 'prospect') DEFAULT 'prospect',
    linkedin_connected ENUM('YES', 'NO') DEFAULT 'NO',
    intro_email_sent ENUM('YES', 'NO') DEFAULT 'NO',
    intro_call ENUM('YES', 'NO') DEFAULT 'NO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    linkedin_internal_id VARCHAR(255)
);

-- Add vendor_id column to vendor_contact_extracts if it doesn't exist
SET @vendor_column_exists = (
    SELECT COUNT(*)
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'vendor_contact_extracts'
      AND column_name = 'vendor_id'
);

SET @sql_vendor_column = IF(@vendor_column_exists = 0,
    'ALTER TABLE vendor_contact_extracts ADD COLUMN vendor_id INT NULL AFTER moved_to_vendor',
    'SELECT 1');

PREPARE stmt1 FROM @sql_vendor_column;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
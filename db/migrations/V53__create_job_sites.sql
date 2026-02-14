CREATE TABLE IF NOT EXISTS job_sites (
  id INT AUTO_INCREMENT PRIMARY KEY,
  
  company_name VARCHAR(100) NOT NULL,
  domain VARCHAR(255) UNIQUE NOT NULL,
  
  ats_platform_id INT DEFAULT NULL,
  category ENUM(
    'System integrator',
    'Consulting firm',
    'Staffing vendor',
    'Product Company'
  ) NOT NULL,
  
  search_url_template TEXT NOT NULL,
  apply_url_template TEXT DEFAULT NULL,
  
  cf_clearance_required BOOLEAN DEFAULT FALSE,
  proxy_region VARCHAR(10) DEFAULT 'US',
  
  is_active BOOLEAN DEFAULT TRUE,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT fk_site_platform 
  FOREIGN KEY (ats_platform_id) 
  REFERENCES ats_platforms(id) 
  ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

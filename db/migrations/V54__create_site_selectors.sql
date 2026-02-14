CREATE TABLE IF NOT EXISTS site_selectors (
  id INT AUTO_INCREMENT PRIMARY KEY,
  
  ats_platform_id INT DEFAULT NULL,
  job_site_id INT DEFAULT NULL,
  
  type ENUM('listing','application') NOT NULL,
  config_json JSON NOT NULL,
  
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT fk_selector_platform 
  FOREIGN KEY (ats_platform_id) 
  REFERENCES ats_platforms(id) 
  ON DELETE CASCADE,
  
  CONSTRAINT fk_selector_site 
  FOREIGN KEY (job_site_id) 
  REFERENCES job_sites(id) 
  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

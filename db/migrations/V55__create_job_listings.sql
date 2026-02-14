CREATE TABLE IF NOT EXISTS job_listings (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  
  job_site_id INT NOT NULL,
  
  external_job_id VARCHAR(100) NOT NULL,
  job_title VARCHAR(255),
  job_url TEXT NOT NULL,
  
  status ENUM(
    'discovered',
    'ready_to_apply',
    'applied',
    'failed',
    'blacklisted'
  ) DEFAULT 'discovered',
  
  attempts INT DEFAULT 0,
  last_error TEXT,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_job_per_site 
  (job_site_id, external_job_id),
  
  CONSTRAINT fk_listing_site 
  FOREIGN KEY (job_site_id) 
  REFERENCES job_sites(id) 
  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

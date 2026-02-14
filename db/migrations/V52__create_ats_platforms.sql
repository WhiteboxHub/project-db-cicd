CREATE TABLE IF NOT EXISTS ats_platforms (
  id INT AUTO_INCREMENT PRIMARY KEY,
  
  name VARCHAR(50) NOT NULL,
  class_handler VARCHAR(100) NOT NULL,
  
  is_headless_required BOOLEAN DEFAULT TRUE,
  
  automation_level ENUM('fully','semi','manual') 
  DEFAULT 'manual',
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

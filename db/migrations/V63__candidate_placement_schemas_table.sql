CREATE TABLE IF NOT EXISTS candidate_placement (
  id int NOT NULL AUTO_INCREMENT,
  candidate_id int NOT NULL,
  position varchar(255) DEFAULT NULL,
  company varchar(200) DEFAULT NULL,
  placement_date date NOT NULL,
  type enum('Company','Client','Vendor','Implementation Partner') DEFAULT NULL,
  status enum('Active','Inactive') NOT NULL,
  base_salary_offered decimal(10,2) DEFAULT NULL,
  benefits text,
  fee_paid decimal(10,2) DEFAULT NULL,
  no_of_installments enum('1','2','3','4','5') DEFAULT NULL,
  notes text,
  last_mod_datetime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  priority int DEFAULT '99',
  PRIMARY KEY (id),
  UNIQUE KEY unique_candidate_company_date (candidate_id,company,placement_date)
) ENGINE=InnoDB;
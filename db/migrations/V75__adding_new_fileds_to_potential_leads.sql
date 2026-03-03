ALTER TABLE potential_leads
  ADD COLUMN outreach_connection_status 
    ENUM('not_sent','sent','accepted') 
    DEFAULT 'not_sent',
  ADD COLUMN outreach_message_status 
    ENUM('not_sent','sent','responded') 
    DEFAULT 'not_sent';
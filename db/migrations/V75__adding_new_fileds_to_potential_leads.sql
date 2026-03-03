ALTER TABLE potential_leads
  ADD COLUMN IF NOT EXISTS outreach_connection_status 
    ENUM('not_sent','sent','accepted') 
    DEFAULT 'not_sent',
  ADD COLUMN IF NOT EXISTS outreach_message_status 
    ENUM('not_sent','sent','responded') 
    DEFAULT 'not_sent';



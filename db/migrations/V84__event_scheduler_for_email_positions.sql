CREATE EVENT IF NOT EXISTS `evt_cleanup_email_positions`
  ON SCHEDULE EVERY 1 DAY
  STARTS CURRENT_TIMESTAMP
  ON COMPLETION PRESERVE
  ENABLE
  COMMENT 'Deletes email_positions records older than 1 day'
  DO
    DELETE FROM `email_positions`
    WHERE `created_at` < NOW() - INTERVAL 1 DAY;
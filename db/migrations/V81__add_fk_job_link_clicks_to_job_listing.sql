ALTER TABLE `job_link_clicks`
  ADD CONSTRAINT `fk_click_job_listing`
  FOREIGN KEY (`job_listing_id`) REFERENCES `job_listing` (`id`) ON DELETE SET NULL;
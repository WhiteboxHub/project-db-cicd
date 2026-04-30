ALTER TABLE `job_listing`
MODIFY COLUMN `source` ENUM(
  'bot_linkedin_post_contact_extractor',
  'bot_linkedin_message_extraction',
  'email',
  'linkedin',
  'job_board',
  'scraper',
  'hiring.cafe',
  'interview_modal',
  'email_bot_llm_local',
  'trueup.io',
  'jobright'
) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'linkedin';

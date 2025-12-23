 CREATE TABLE IF NOT EXISTS job_automation_keywords (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(50) NOT NULL COMMENT 'blocked_personal_domain, allowed_staffing_domain, etc.',
  source VARCHAR(50) NOT NULL DEFAULT 'email_extractor' COMMENT 'Which extractor uses this',
  keywords TEXT NOT NULL COMMENT 'Comma-separated: gmail.com,yahoo.com,outlook.com',
  match_type ENUM('exact', 'contains', 'regex') NOT NULL DEFAULT 'contains' COMMENT 'How to match',
  action ENUM('allow', 'block') DEFAULT 'block' COMMENT 'allow or block',
  priority INT DEFAULT 100 COMMENT 'Lower = higher priority. Allowlist=1, Blocklist=100',
  context TEXT COMMENT 'Why this filter exists',
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_category (category),
  INDEX idx_active (is_active),
  INDEX idx_priority (priority)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- PRIORITY 1: ALLOWLIST (Always processed first)
-- ============================================================================

INSERT INTO job_automation_keywords (category, source, keywords, match_type, action, priority, context) VALUES
('allowed_staffing_domain', 'email_extractor', 'teksystems.com,randstad.com,manpowergroup.com,adecco.com,kellyservices.com,roberthalf.com,insight.com,hays.com,michaelpage.com,modis.com,aerotek.com,experis.com,kforce.com,apexsystems.com,cybercoders.com,akraya.com,intelliswift.com,net2source.com,eteaminc.com', 'contains', 'allow', 1, 'Legitimate staffing agencies - always allow')

INSERT INTO job_automation_keywords (category, source, keywords, match_type, action, priority, context) VALUES
('blocked_personal_domain', 'email_extractor', 'gmail.com,googlemail.com,yahoo.com,yahoo.co.uk,yahoo.co.in,outlook.com,hotmail.com,live.com,msn.com,icloud.com,me.com,mac.com,aol.com,protonmail.com,proton.me,pm.me,mail.com,zoho.com,yandex.com,gmx.com,gmx.de,web.de,mail.ru,qq.com,163.com,126.com,rediffmail.com', 'contains', 'block', 100, 'Personal email domains'),

('blocked_edu_domain', 'email_extractor', 'student\\..*,alumni\\..*,academy\\..*,school\\..*,college\\..*,university\\..*,\\.edu$,\\.edu\\.', 'regex', 'block', 100, 'Educational domains'),

('blocked_test_domain', 'email_extractor', 'test.com,example.com,demo.com,sample.com,fake.com,testing.com,dummy.com', 'exact', 'block', 100, 'Test/fake domains'),

('blocked_marketing_domain', 'email_extractor', 'neo4j.com,oreilly.com,medium.com,canva.com,anthropic.com,replit.com,udemy.com,coursera.org,edx.org,pluralsight.com', 'exact', 'block', 100, 'Marketing/newsletter platforms'),

('blocked_jobboard_domain', 'email_extractor', 'jobleads.com,lensa.com,jobcase.com,postjobfree.com,ihire.com,aiapply.co,directlyapply.com,jobs2web.com,jobvite.com,smartrecruiters.com,clearcompany.com,myworkday.com,wellfound.com,paraform.com,dice.com,monster.com,glassdoor.com,careerbuilder.com,ziprecruiter.com,simplyhired.com,snagajob.com,ladders.com,hired.com,angel.co,builtin.com', 'exact', 'block', 100, 'Job board platforms'),

('blocked_linkedin_domain', 'email_extractor', 'linkedin.com,e.linkedin.com,em.linkedin.com', 'exact', 'block', 100, 'LinkedIn automated emails'),

('blocked_saas_domain', 'email_extractor', 'fireflies.ai,zapier.com,doordash.com,lyrahealth.com,brighthire.ai,trucksmarter.com,labelbox.com,mywisely.com,fedex.com,ups.com,usps.com,dhl.com,stripe.com,paypal.com,venmo.com', 'exact', 'block', 100, 'SaaS/product companies'),

('blocked_spam_domain', 'email_extractor', 'spam.com,trashmail.com,temp-mail.org,mailinator.com,guerrillamail.com,10minutemail.com,throwaway.email,tempmail.com,maildrop.cc,fakeinbox.com', 'exact', 'block', 100, 'Spam/temp mail services'),

('blocked_internal_domain', 'email_extractor', 'innova-path.com,whitebox-learning.com', 'exact', 'block', 100, 'Internal company domains'),

('blocked_calendar_domain', 'email_extractor', 'calendar.google.com,calendly.com,cal.com,chili-piper.com,teams.microsoft.com,zoom.us,meet.google.com,webex.com', 'exact', 'block', 100, 'Calendar/meeting platforms'),

('blocked_emailmarketing_domain', 'email_extractor', 'mailchimp.com,sendgrid.net,constantcontact.com,awsmail.com,amazonses.com,sparkpostmail.com,mandrillapp.com,postmarkapp.com,mailgun.org,sendinblue.com,customeriomail.com,intercom-mail.com', 'exact', 'block', 100, 'Email marketing services'),

('blocked_ats_domain', 'email_extractor', 'greenhouse.io,lever.co,icims.com,successfactors.com,taleo.net,bullhorn.com,jazz.co,breezy.hr,recruitee.com,ashbyhq.com,gem.com', 'exact', 'block', 100, 'ATS software automated emails'),

('blocked_sms_gateway', 'email_extractor', 'txt.voice.google.com,sms.twilio.com,messaging.bandwidth.com,vtext.com,tmomail.net,mms.att.net', 'exact', 'block', 100, 'SMS-to-email gateways'),

('blocked_social_domain', 'email_extractor', 'twitter.com,x.com,instagram.com,facebook.com,tiktok.com,snapchat.com,pinterest.com,reddit.com,quora.com,stackoverflow.com', 'exact', 'block', 100, 'Social media platforms');

INSERT INTO job_automation_keywords (category, source, keywords, match_type, action, priority, context) VALUES
('blocked_automated_prefix', 'email_extractor', '^donotreply@,^no-reply@,^noreply@,^do_not_reply@,^do-not-reply@,^noreplies@,^notification@,^notifications@,^autoresponder@,^tracking@,^calendar-notification@,^echosign@,^mailer@,^aggregated@,^automated@,^system@,^bounce@,^postmaster@,^daemon@', 'regex', 'block', 100, 'Automated email prefixes'),

('blocked_generic_prefix', 'email_extractor', '^no-reply@,^do-not-reply@,^notifications@,^jobs@,^info@,^noreply@,^newsletter@,^alerts@,^update@,^updates@,^donotreply@,^support@,^admin@,^system@,^bounce@,^postmaster@,^auto@,^digest@,^bulk@,^mail@,^email@,^news@,^press@,^media@,^marketing@,^sales@,^events@,^webinar@', 'regex', 'block', 100, 'Generic automated prefixes'),

('blocked_reply_pattern', 'email_extractor', '^reply-,^email-replies\\+,^c_[a-f0-9]{20,},^[0-9]{10,}\\.[0-9]{10,}', 'regex', 'block', 100, 'Auto-generated reply addresses'),

('blocked_linkedin_email', 'email_extractor', 'jobs-listings@linkedin,newsletters-noreply@linkedin,inmail-hit-reply@linkedin,hit-reply@linkedin,messages-noreply@linkedin,jobalerts-noreply@linkedin,invitations@linkedin', 'contains', 'block', 100, 'LinkedIn specific emails'),

('blocked_indeed_email', 'email_extractor', 'indeedapply@indeed,noreply@indeed,jobalerts@indeed', 'contains', 'block', 100, 'Indeed specific emails'),

('blocked_test_email', 'email_extractor', '^test@,^demo@,@test\\.,@demo\\.,@example\\.', 'regex', 'block', 100, 'Test/demo email patterns'),

('blocked_exchange', 'email_extractor', 'microsoftexchange', 'contains', 'block', 100, 'Microsoft Exchange system emails');

INSERT INTO job_automation_keywords (category, source, keywords, match_type, action, priority, context) VALUES
('recruiter_keywords', 'email_extractor', 'recruit,hiring,opportunity,position,talent,career,role,interview,vendor,staffing,consultant,placement,headhunter,agency,candidate,resume,cv,contract,full time,full-time,w2,corp to corp,c2c,1099,opening,vacancy,bench', 'contains', 'allow', 200, 'Positive recruiter indicators'),

('anti_recruiter_keywords', 'email_extractor', 'unsubscribe,webinar,newsletter,subscription,courses,training,certification,learn more,free trial,sign up,register now,limited time,download,ebook,whitepaper,case study,product launch,new features', 'contains', 'block', 200, 'Marketing/spam indicators');

INSERT INTO job_automation_keywords
(category, source, keywords, match_type, action, priority, context)
VALUES
(
 'blocked_exact_email',
 'email_extractor',
 'teamzoom@zoom.us,ops@cluso.com,recruiter@softquip.com,requirements@gainamerica.net,assistant@glider.ai,echosign@echosign.com,aggregated@lensa.com,e.linkedin.com,hello@v3.idibu.com',
 'exact',
 'block',
 1,
 'Hard-coded exact sender blacklist moved from code'
);


INSERT INTO job_automation_keywords
(category, source, keywords, match_type, action, priority, context)
VALUES
(
 'blocked_system_localpart',
 'email_extractor',
 'email-replies,noreply,no-reply,mailer,bounce,alerts,notifications,jobs,info,support,admin,system,tracking,calendar-notification',
 'exact',
 'block',
 50,
 'Exact system sender local-parts (faster than regex)'
);

INSERT INTO job_automation_keywords
(category, source, keywords, match_type, action, priority, context)
VALUES
(
 'allowed_jobboard_domain',
 'email_extractor',
 'dice.com,ziprecruiter.com,monster.com,careerbuilder.com,glassdoor.com',
 'exact',
 'allow',
 2,
 'Legitimate job boards allowed as recruiter sources'
);

INSERT INTO job_automation_keywords
(category, source, keywords, match_type, action, priority, context)
VALUES
(
 'allowed_calendar_domain',
 'email_extractor',
 'calendly.com,cal.com,chili-piper.com,teams.microsoft.com,zoom.us,meet.google.com,webex.com',
 'exact',
 'allow',
 2,
 'Calendar scheduling platforms (allow calendar invites)'
);

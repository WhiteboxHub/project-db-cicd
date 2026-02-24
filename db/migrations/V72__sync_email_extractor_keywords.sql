-- ============================================================================
-- V72: Sync Email Extractor Keywords from CSV (2026-02-24)
-- ============================================================================
-- Previous migrations coverage:
--   V6   : IDs 1-28  (auto-assigned, all base filter rows)
--   V30  : IDs 29-49
--   V44  : Updates to IDs 5, 13
--   V46  : IDs 50-72
--
-- This migration:
--   UPDATEs: IDs 16, 17, 32, 33, 94  (updated_at = 2026-02-22 in CSV)
--   INSERTs: IDs 73-98, 101-105       (new rows added to keywords.csv)
-- ============================================================================


-- ============================================================================
-- SECTION 1: UPDATE EXISTING ROWS CHANGED ON 2026-02-22
-- ============================================================================

-- ID 16: blocked_automated_prefix — added ^workdayalert@,^workday@
UPDATE job_automation_keywords
SET keywords    = '^donotreply@,^no-reply@,^noreply@,^do_not_reply@,^do-not-reply@,^noreplies@,^notification@,^notifications@,^autoresponder@,^tracking@,^calendar-notification@,^echosign@,^mailer@,^aggregated@,^automated@,^system@,^bounce@,^postmaster@,^daemon@,^workdayalert@,^workday@',
    updated_at  = '2026-02-05 17:18:00'
WHERE id = 16;

-- ID 17: blocked_generic_prefix — added recruiting/talent/hr/careers/apply/resume/screening/sourcing/booking/scheduling prefixes
UPDATE job_automation_keywords
SET keywords    = '^no-reply@,^do-not-reply@,^notifications@,^jobs@,^info@,^noreply@,^newsletter@,^alerts@,^update@,^updates@,^donotreply@,^support@,^admin@,^system@,^bounce@,^postmaster@,^auto@,^digest@,^bulk@,^mail@,^email@,^news@,^press@,^media@,^marketing@,^sales@,^events@,^webinar@,^recruiting@,^talent@,^hr@,^careers@,^apply@,^resume@,^screening@,^sourcing@,^booking@,^scheduling@',
    updated_at  = '2026-02-22 08:45:00'
WHERE id = 17;

-- ID 32: greeting_patterns — expanded significantly with full_name, ai_assistant, rose international, etc.
UPDATE job_automation_keywords
SET keywords    = 'dear,hi,hello,hey,greetings,team,sir,madam,folks,all,recipient,candidate,applicant,full name,first name,last name,your name,name here,firstname,lastname,fullname,booking,notes,postmaster,recruiting,eximius,scheduling,system generated,do not reply,rose international,talent acquisition team,ai assistant',
    updated_at  = '2026-02-22 08:45:00'
WHERE id = 32;

-- ID 33: company_indicators — expanded with recruiting,talent,acquisition,staffing,hiring,system,generated,eximius,booking,notes,desk,postmaster,scheduling
UPDATE job_automation_keywords
SET keywords    = 'team,group,department,inc,llc,corp,ltd,recruiting,talent,acquisition,staffing,hiring,system,generated,eximius,booking,notes,desk,postmaster,scheduling',
    updated_at  = '2026-02-22 08:45:00'
WHERE id = 33;

-- ID 94: location_generic_words — added google meet,zoom,meet,virtual,remote,scheduling,booking,ai,ml,gemini,us,usa
UPDATE job_automation_keywords
SET keywords    = 'area,story,team,group,department,division,unit,office,branch,google meet,zoom,meet,virtual,remote,scheduling,booking,ai,ml,gemini,us,usa',
    updated_at  = '2026-02-22 08:45:00'
WHERE id = 94;


-- ============================================================================
-- SECTION 2: INSERT NEW ROWS (IDs 73-98)
-- ============================================================================

INSERT INTO job_automation_keywords (id, category, source, keywords, match_type, action, priority, context, is_active, created_at, updated_at) VALUES
(73, 'blocked_marketing_subdomain', 'email_extractor', '^nurture\\.,^marketing\\.,^newsletter\\.,^alerts\\.,^notifications\\.,^promo\\.,^campaigns\\.,^announce\\.', 'regex', 'block', 100, 'Marketing/automated subdomains', 1, '2026-02-05 17:18:00', '2026-02-05 17:18:00'),
(74, 'blocked_spam_tld', 'email_extractor', '\\.xyz$,\\.top$,\\.club$,\\.store$,\\.online$,\\.site$,\\.space$,\\.website$,\\.info$,\\.biz$,\\.click$,\\.link$', 'regex', 'block', 100, 'Spam/low-quality TLDs', 1, '2026-02-05 17:18:00', '2026-02-05 17:18:00'),
(75, 'blocked_training_domain', 'email_extractor', 'training,courses,academy,learning,education,certification,bootcamp,workshop,tutorial,elearning,udemy,coursera,edx', 'contains', 'block', 100, 'Training/education marketing domains', 1, '2026-02-05 17:18:00', '2026-02-05 17:18:00'),
(76, 'blocked_uuid_pattern', 'email_extractor', '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$', 'regex', 'block', 100, 'UUID pattern in localpart', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(77, 'blocked_md5_hash', 'email_extractor', '^[a-f0-9]{32,}$', 'regex', 'block', 100, 'MD5/SHA hash in localpart', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(78, 'blocked_plus_tracking', 'email_extractor', '\\+[a-z0-9]+\\+[a-f0-9]{10,}', 'regex', 'block', 100, 'Plus-based tracking pattern', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(79, 'blocked_desk_prefix', 'email_extractor', '^(screening|hiring|recruiting|talent)desk\\.', 'regex', 'block', 100, 'Desk patterns in localpart', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(80, 'blocked_workday_dots', 'email_extractor', 'workday.*\\..*\\.', 'regex', 'block', 100, 'Workday with multiple dots', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(81, 'blocked_excessive_subdomains', 'email_extractor', '\\.\\.\\.\\.',  'regex', 'block', 100, '4+ dots in domain (excessive subdomains)', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(82, 'blocked_bot_pattern', 'email_extractor', '^[a-z]{3,}[0-9]{3,}$', 'regex', 'block', 100, 'Generic bot pattern (letters+numbers)', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(83, 'position_generic_tech_terms', 'email_extractor', 'cloud environments,tech stack,software engineering', 'contains', 'block', 50, 'Generic tech terms without role context', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(84, 'position_portal_indicators', 'email_extractor', ' portal, system, platform, dashboard', 'contains', 'block', 50, 'Portal/system name indicators', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(85, 'position_false_positives', 'email_extractor', 'team,department,company,organization,group,please,thank,regards,sincerely,best,email,phone,contact,address', 'contains', 'block', 50, 'Common false positive words in positions', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(86, 'position_company_suffix', 'email_extractor', ' software, inc, llc, corp, ltd, portal, ''s candidate portal', 'contains', 'block', 50, 'Company suffixes that indicate company names not positions', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(87, 'employment_patterns', 'email_extractor', 'W2|\\bW-?2\\b;\\bW\\s*2\\b,C2C|\\bC-?2-?C\\b;\\bCorp\\s*to\\s*Corp\\b;\\bCorp-to-Corp\\b,1099|\\b1099\\b;\\bIndependent\\s+Contractor\\b,Full-time|\\bFull-?time\\b;\\bFull\\s+Time\\b;\\bFT\\b;\\bPermanent\\b;\\bPerm\\b,Contract|\\bContract\\b;\\bContractor\\b;\\bCTR\\b;\\bTemp\\b;\\bTemporary\\b,Part-time|\\bPart-?time\\b;\\bPart\\s+Time\\b;\\bPT\\b,Remote|\\bRemote\\b;\\bWork from Home\\b;\\bWFH\\b;\\b100%\\s*Remote\\b;\\bFully\\s*Remote\\b,Hybrid|\\bHybrid\\b;\\bPartially\\s*Remote\\b;\\bRemote/Onsite\\b,Onsite|\\bOnsite\\b;\\bOn-site\\b;\\bOn\\s*site\\b;\\bIn-office\\b;\\bIn\\s*office\\b', 'regex', 'allow', 200, 'Employment type patterns (format: Type|Pattern1;Pattern2)', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(88, 'location_common_phrases', 'email_extractor', 'thank you,kind regards,best regards,sincerely,regards,thanks,cheers,yours,respectfully,cordially,warmly,looking forward', 'contains', 'block', 50, 'Common phrases that are NOT city names', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(89, 'location_tech_terms', 'email_extractor', 'sql,api,aws,gcp,azure,cloud,java,python,react,node,docker,kubernetes', 'contains', 'block', 50, 'Technology terms that are NOT city names', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(90, 'location_verbs_adjectives', 'email_extractor', 'growing,managing,leading,developing,building,creating,designing,testing,working,including,ensuring,providing,supporting,maintaining', 'contains', 'block', 50, 'Common verbs/adjectives that are NOT city names', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(91, 'location_invalid_prefixes', 'email_extractor', 'or,and,for,with,from,to', 'exact', 'block', 50, 'Conjunctions/prepositions that should not start city names', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(92, 'location_business_suffixes', 'email_extractor', 'inc,llc,corp,ltd,limited,corporation,solutions,technologies,systems,services,consulting,group,partners,associates', 'contains', 'block', 50, 'Business suffixes to identify company names as locations', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(93, 'location_html_artifacts', 'email_extractor', '&nbsp,&amp,&quot,&lt,&gt,&#,\\u0026nbsp,nbsp,quot,amp', 'contains', 'block', 50, 'HTML artifacts in junk locations', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(94, 'location_generic_words', 'email_extractor', 'area,story,team,group,department,division,unit,office,branch,google meet,zoom,meet,virtual,remote,scheduling,booking,ai,ml,gemini,us,usa', 'contains', 'block', 50, 'Generic single words that are NOT cities', 1, '2026-02-05 00:00:00', '2026-02-22 08:45:00'),
(95, 'location_prefixes_to_remove', 'email_extractor', 'Agent Santa Clara,Engineer At,Location Of,Onsite In,Based In,Located In,Ca Or,Or,And,At,In,Various', 'contains', 'block', 50, 'Prefixes to remove from location strings', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(96, 'ner_location_indicators', 'email_extractor', 'alabama,alaska,arizona,arkansas,california,colorado,connecticut,delaware,florida,georgia,hawaii,idaho,illinois,indiana,iowa,kansas,kentucky,louisiana,maine,maryland,massachusetts,michigan,minnesota,mississippi,missouri,montana,nebraska,nevada,new hampshire,new jersey,new mexico,new york,north carolina,north dakota,ohio,oklahoma,oregon,pennsylvania,rhode island,south carolina,south dakota,tennessee,texas,utah,vermont,virginia,washington,west virginia,wisconsin,wyoming,ca,ny,tx,fl,il,pa,oh,ga,nc,mi,nj,va,wa,az,ma,tn,in,mo,md,wi,co,mn,sc,al,la,ky,or,ok,ct,ia,ut,ar,nv,ms,ks,nm,ne,wv,id,hi,nh,me,ri,mt,de,sd,nd,ak,dc,vt,wy,city,town,county,state,province,region,area,district,united states,usa,us,uk,united kingdom,canada,australia,north,south,east,west,northern,southern,eastern,western,upper,lower,central,metro,greater', 'contains', 'block', 50, 'NER location indicators for company validation', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(97, 'ner_common_cities', 'email_extractor', 'new york,los angeles,chicago,houston,phoenix,philadelphia,san antonio,san diego,dallas,san jose,austin,jacksonville,san francisco,indianapolis,columbus,fort worth,charlotte,seattle,denver,washington,boston,el paso,detroit,nashville,portland,oklahoma city,las vegas,memphis,louisville,baltimore,milwaukee,albuquerque,tucson,fresno,sacramento,kansas city,mesa,atlanta,omaha,colorado springs,raleigh,virginia beach,miami,oakland,minneapolis,tulsa,cleveland,wichita,arlington,tampa,new orleans,honolulu,london,paris,tokyo,sydney,toronto,vancouver,montreal,mumbai,delhi,bangalore,singapore', 'exact', 'block', 50, 'Common cities for NER location validation', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00'),
(98, 'ner_company_suffixes', 'email_extractor', 'inc,llc,corp,ltd,limited,corporation,incorporated,co,company,group,solutions,services,technologies,tech,systems', 'contains', 'allow', 300, 'Company suffixes for NER confidence scoring', 1, '2026-02-05 00:00:00', '2026-02-05 00:00:00');

-- Note: IDs 99 and 100 are intentionally skipped (not present in keywords.csv)


-- ============================================================================
-- SECTION 3: INSERT NEW ROWS (IDs 101-105) — Recruiter title classifiers
-- ============================================================================

INSERT INTO job_automation_keywords (id, category, source, keywords, match_type, action, priority, context, is_active, created_at, updated_at) VALUES
(101, 'recruiter_title_strong', 'email_extractor', 'recruiter,recruiting,talent acquisition,staffing,sourcer,talent partner,recruitment,hiring manager,headhunter,talent scout,search consultant,placement,staffing specialist', 'contains', 'allow', 200, 'Strong recruiter job titles', 1, '2026-02-16 12:00:00', '2026-02-16 12:00:00'),
(102, 'recruiter_title_moderate', 'email_extractor', 'hr,human resources,matchmaker,resource manager,account manager,client partner,business development,sales manager,hiring,people ops,people operations,talent,resourcing', 'contains', 'allow', 100, 'Moderate recruiter job titles', 1, '2026-02-16 12:00:00', '2026-02-16 12:00:00'),
(103, 'recruiter_title_weak', 'email_extractor', 'manager,director,lead,coordinator,partner,consultant,associate,specialist,analyst,vp,president,founder,ceo', 'contains', 'allow', 50, 'Weak recruiter job titles (ambiguous)', 1, '2026-02-16 12:00:00', '2026-02-16 12:00:00'),
(104, 'recruiter_title_negative', 'email_extractor', 'software engineer,developer,architect,programmer,data scientist,product manager,project manager,scrum master,marketing,sales representative,customer success,support', 'contains', 'block', 200, 'Negative recruiter indicators (tech roles)', 1, '2026-02-16 12:00:00', '2026-02-16 12:00:00'),
(105, 'recruiter_context_positive', 'email_extractor', 'i am a recruiter,my client is looking,we are looking to hire,staffing agency,recruiting team', 'contains', 'allow', 150, 'Context phrases indicating recruiter', 1, '2026-02-16 12:00:00', '2026-02-16 12:00:00');


-- ============================================================================
-- Migration Complete — Total: 5 UPDATEs + 31 INSERTs (IDs 73-98, 101-105)
-- ============================================================================

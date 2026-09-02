-- AI PREP DATABASE CLEANUP MIGRATION (V133)

-- Drops ALL 14 AI Prep tables created in V131.


SET FOREIGN_KEY_CHECKS = 0;

-- Depends on: ai_prep_assessments, ai_prep_question_bank
DROP TABLE IF EXISTS `ai_prep_assessment_questions`;

-- Depends on: ai_prep_assessments
DROP TABLE IF EXISTS `ai_prep_analysis_runs`;
DROP TABLE IF EXISTS `ai_prep_audio_telemetry`;
DROP TABLE IF EXISTS `ai_prep_vision_telemetry`;
DROP TABLE IF EXISTS `ai_prep_transcripts`;
DROP TABLE IF EXISTS `ai_prep_media_files`;
DROP TABLE IF EXISTS `ai_prep_hardware_checks`;
DROP TABLE IF EXISTS `ai_prep_reports`;
DROP TABLE IF EXISTS `ai_prep_share_grants`;

-- Depends on: candidate (external table — FK only, safe to drop)
DROP TABLE IF EXISTS `ai_prep_assessments`;
DROP TABLE IF EXISTS `ai_prep_consents`;
DROP TABLE IF EXISTS `ai_prep_deletion_requests`;


-- Root / standalone tables (no FK children remaining)

DROP TABLE IF EXISTS `ai_prep_audit_events`;
DROP TABLE IF EXISTS `ai_prep_question_bank`;


SET FOREIGN_KEY_CHECKS = 1;

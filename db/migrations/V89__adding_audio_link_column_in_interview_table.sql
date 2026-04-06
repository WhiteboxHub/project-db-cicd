ALTER TABLE candidate_interview
ADD COLUMN audio_link VARCHAR(500) DEFAULT NULL AFTER recording_link;
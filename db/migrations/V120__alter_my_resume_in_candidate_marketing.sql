ALTER TABLE candidate_marketing
DROP COLUMN my_resume;

ALTER TABLE candidate_marketing
ADD COLUMN my_resume LONGBLOB NULL,
ADD COLUMN my_resume_filename VARCHAR(255) NULL;

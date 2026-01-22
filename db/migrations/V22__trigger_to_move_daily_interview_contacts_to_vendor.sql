DELIMITER //

CREATE FUNCTION get_existing_vendor_id(
    p_email VARCHAR(255),
    p_phone VARCHAR(50),
    p_linkedin VARCHAR(255)
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_vendor_id INT DEFAULT NULL;
    
    
    SELECT id INTO v_vendor_id 
    FROM vendor 
    WHERE 
        (p_email IS NOT NULL 
         AND p_email != '' 
         AND email COLLATE utf8mb4_unicode_ci = p_email COLLATE utf8mb4_unicode_ci)
        OR 
        (p_linkedin IS NOT NULL 
         AND p_linkedin != '' 
         AND linkedin_id COLLATE utf8mb4_unicode_ci = p_linkedin COLLATE utf8mb4_unicode_ci)
        OR 
        (p_phone IS NOT NULL 
         AND p_phone != '' 
         AND phone_number = p_phone)
    ORDER BY id ASC  -- Always get the oldest/first record
    LIMIT 1;
    
    RETURN v_vendor_id;
END//

-- ============================================================================
-- STEP 3: CREATE INSERT TRIGGER
-- ============================================================================

CREATE TRIGGER trg_candidate_interview_insert_sync_vendor
AFTER INSERT ON candidate_interview
FOR EACH ROW
BEGIN
    DECLARE v_existing_vendor_id INT;
    
    -- Error handler: Don't fail interview insert if vendor sync fails
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Silently continue - interview data is more important
    END;
    
    -- Check if vendor exists using ANY of the contact information
    SET v_existing_vendor_id = get_existing_vendor_id(
        NEW.interviewer_emails,
        NEW.interviewer_contact,
        NEW.interviewer_linkedin
    );
    
    IF v_existing_vendor_id IS NULL THEN
        -- Vendor doesn't exist, INSERT new record
        INSERT INTO vendor (
            company_name,
            email,
            phone_number,
            linkedin_id,
            type,
            status,
            created_at
        )
        VALUES (
            NEW.company,
            NEW.interviewer_emails,
            NEW.interviewer_contact,
            NEW.interviewer_linkedin,
            NEW.company_type,
            'prospect',
            NOW()
        );
    ELSE
        -- Vendor exists, UPDATE existing record
        UPDATE vendor
        SET 
            company_name = COALESCE(NEW.company, company_name),
            email = COALESCE(NEW.interviewer_emails, email),
            phone_number = COALESCE(NEW.interviewer_contact, phone_number),
            linkedin_id = COALESCE(NEW.interviewer_linkedin, linkedin_id),
            type = NEW.company_type
        WHERE id = v_existing_vendor_id;
    END IF;
END//

-- ============================================================================
-- STEP 4: CREATE UPDATE TRIGGER
-- ============================================================================

CREATE TRIGGER trg_candidate_interview_update_sync_vendor
AFTER UPDATE ON candidate_interview
FOR EACH ROW
BEGIN
    DECLARE v_existing_vendor_id INT;
    DECLARE v_has_changes BOOLEAN DEFAULT FALSE;
    
    -- Error handler: Don't fail interview update if vendor sync fails
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Silently continue - interview data is more important
    END;
    
    -- Check if relevant fields have changed (NULL-safe comparison)
    IF (COALESCE(OLD.company, '') != COALESCE(NEW.company, '')) OR 
       (COALESCE(OLD.interviewer_emails, '') != COALESCE(NEW.interviewer_emails, '')) OR
       (COALESCE(OLD.interviewer_contact, '') != COALESCE(NEW.interviewer_contact, '')) OR
       (COALESCE(OLD.interviewer_linkedin, '') != COALESCE(NEW.interviewer_linkedin, '')) OR
       (OLD.company_type != NEW.company_type) THEN
        
        SET v_has_changes = TRUE;
    END IF;
    
    -- Only proceed if there are actual changes
    IF v_has_changes THEN
        
      
        SET v_existing_vendor_id = get_existing_vendor_id(
            COALESCE(NEW.interviewer_emails, OLD.interviewer_emails),
            COALESCE(NEW.interviewer_contact, OLD.interviewer_contact),
            COALESCE(NEW.interviewer_linkedin, OLD.interviewer_linkedin)
        );
        
        IF v_existing_vendor_id IS NULL THEN
            -- Vendor doesn't exist (shouldn't happen on UPDATE, but handle it)
            INSERT INTO vendor (
                company_name,
                email,
                phone_number,
                linkedin_id,
                type,
                status,
                created_at
            )
            VALUES (
                NEW.company,
                NEW.interviewer_emails,
                NEW.interviewer_contact,
                NEW.interviewer_linkedin,
                NEW.company_type,
                'prospect',
                NOW()
            );
        ELSE
            -- Vendor exists, UPDATE with new information
            UPDATE vendor
            SET 
                company_name = COALESCE(NEW.company, company_name),
                email = COALESCE(NEW.interviewer_emails, email),
                phone_number = COALESCE(NEW.interviewer_contact, phone_number),
                linkedin_id = COALESCE(NEW.interviewer_linkedin, linkedin_id),
                type = NEW.company_type
            WHERE id = v_existing_vendor_id;
        END IF;
    END IF;
END//

DELIMITER ;
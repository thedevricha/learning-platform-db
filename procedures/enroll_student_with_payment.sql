-- =====================
-- Stored Procedure
-- =====================
/* 
Goal: Enroll a student in a course and automatically insert a payment
*/

-- Create a stored procedure for enrolling a student in a course with payment
CREATE OR REPLACE PROCEDURE enroll_student_with_payment(
    p_student_id INT,
    p_course_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_enrollment_id INT;
    v_payment_id INT;
    v_course_exists BOOLEAN;
    v_student_exists BOOLEAN;
    v_course_price DECIMAL(10,2);
    v_is_already_enrolled BOOLEAN;
BEGIN
    -- Check if student exists
    SELECT EXISTS(SELECT 1 FROM student WHERE id = p_student_id) INTO v_student_exists;
    
    IF NOT v_student_exists THEN
        RAISE EXCEPTION 'Student with ID % does not exist', p_student_id;
    END IF;
    
    -- Check if course exists and get price
    SELECT EXISTS(SELECT 1 FROM course WHERE id = p_course_id) INTO v_course_exists;
    
    IF NOT v_course_exists THEN
        RAISE EXCEPTION 'Course with ID % does not exist', p_course_id;
    END IF;
    
    -- Get the course price
    SELECT price INTO v_course_price FROM course WHERE id = p_course_id;
    
    -- Check if student is already enrolled in the course
    SELECT EXISTS(
        SELECT 1 
        FROM enrollment 
        WHERE student_id = p_student_id 
        AND course_id = p_course_id
    ) INTO v_is_already_enrolled;
    
    IF v_is_already_enrolled THEN
        RAISE EXCEPTION 'Student % is already enrolled in course %', p_student_id, p_course_id;
    END IF;
    
    BEGIN
        -- Insert enrollment record
        INSERT INTO enrollment (student_id, course_id)
        VALUES (p_student_id, p_course_id)
        RETURNING id INTO v_enrollment_id;
        
        -- Insert payment record
        INSERT INTO payment (
            student_id, 
            course_id, 
            amount
        )
        VALUES (
            p_student_id, 
            p_course_id, 
            v_course_price
        )
        RETURNING id INTO v_payment_id;
        
        -- If everything succeeded, commit and return success message
        RAISE NOTICE 'Student % successfully enrolled in course % with payment ID %', 
                     p_student_id, p_course_id, v_payment_id;
        
    EXCEPTION
        WHEN OTHERS THEN
            -- Check where the error occurred and roll back appropriately
            IF v_enrollment_id IS NOT NULL THEN
                RAISE NOTICE 'Payment failed. Rolling back to after enrollment point.';
                RAISE EXCEPTION 'Payment processing failed: %', SQLERRM;
            ELSE
                RAISE NOTICE 'Enrollment failed. Rolling back to beginning.';
                RAISE EXCEPTION 'Enrollment failed: %', SQLERRM;
            END IF;
    END;
END;
$$;

-- Example usage:
CALL enroll_student_with_payment(1, 2);

-- Check data
SELECT * FROM enrollment ORDER BY id DESC
SELECT * FROM payment ORDER BY id DESC

------------------------------------------------------------------------------------------

/* GOAL: Insert course category */
-- Fixed version of the stored procedure without explicit COMMIT
CREATE OR REPLACE PROCEDURE insert_course_category(
    p_name VARCHAR(100),
    p_description TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the new course category
    INSERT INTO course_category (name, description)
    VALUES (p_name, p_description);
    
    RAISE NOTICE 'Course category "%" successfully created', p_name;
EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'A course category with the name "%" already exists', p_name;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating course category: %', SQLERRM;
END;
$$;

-- Alternative version with automatic transaction handling
CREATE OR REPLACE PROCEDURE insert_course_category_v2(
    p_name VARCHAR(100),
    p_description TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the new course category
    INSERT INTO course_category (name, description)
    VALUES (p_name, p_description);
    
    RAISE NOTICE 'Course category "%" successfully created', p_name;
EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'A course category with the name "%" already exists', p_name;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating course category: %', SQLERRM;
END;
$$;

-- Example usage:
CALL insert_course_category('PHP', 'PHP programming language courses');
CALL insert_course_category_v2('Software Development', 'Software Development courses');

-- Drop multiple procedures
DROP PROCEDURE IF EXISTS insert_course_category CASCADE;
DROP PROCEDURE IF EXISTS insert_course_category_ignore_duplicates CASCADE;

-- To see a list of all procedures before dropping
SELECT 
    routine_name, 
    routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_type = 'PROCEDURE'
ORDER BY routine_name;
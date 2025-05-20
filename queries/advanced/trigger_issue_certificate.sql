-- =====================
-- Triggers
-- =====================
/* GOAL: 
    Automatically issue a certificate when a student submits their last pending assignment for a course. 
*/

-- Drop previous triggers and functions safely
DROP TRIGGER IF EXISTS trigger_issue_certificate ON submission;
DROP FUNCTION IF EXISTS issue_certificate_if_complete();

DROP TRIGGER IF EXISTS trigger_certificate_audit ON certificate;
DROP FUNCTION IF EXISTS audit_certificate_changes();

------------------------------------------------------
-- FUNCTION: Issue Certificate if Course Completed
------------------------------------------------------
CREATE OR REPLACE FUNCTION issue_certificate_if_complete()
RETURNS TRIGGER AS $$
DECLARE
    v_course_id INT;
    v_enrollment_id INT;
    total_assignments INT;
    completed_assignments INT;
BEGIN
    -- 1. Get the course_id of the assignment being submitted
    SELECT course_id INTO v_course_id
    FROM assignment
    WHERE id = NEW.assignment_id;

    IF v_course_id IS NULL THEN
        RAISE NOTICE 'No course_id found for assignment_id %', NEW.assignment_id;
        RETURN NEW;
    END IF;

    -- 2. Get enrollment_id for student in the course
    SELECT id INTO v_enrollment_id
    FROM enrollment
    WHERE student_id = NEW.student_id AND course_id = v_course_id;

    IF v_enrollment_id IS NULL THEN
        RAISE NOTICE 'No enrollment found for student % in course %', NEW.student_id, v_course_id;
        RETURN NEW;
    END IF;

    -- 3. Exit early if certificate already exists
    IF EXISTS (SELECT 1 FROM certificate WHERE enrollment_id = v_enrollment_id) THEN
        RAISE NOTICE 'Certificate already exists for enrollment_id %', v_enrollment_id;
        RETURN NEW;
    END IF;

    -- 4. Get total number of assignment for the course
    SELECT COUNT(*) INTO total_assignments
    FROM assignment
    WHERE course_id = v_course_id;

    -- 5. Get number of completed (distinct) assignment by the student
    SELECT COUNT(DISTINCT s.assignment_id) INTO completed_assignments
    FROM submission s
    JOIN assignment a ON s.assignment_id = a.id
    WHERE s.student_id = NEW.student_id AND a.course_id = v_course_id;

    RAISE NOTICE 'Debug: course_id = %, enrollment_id = %, total = %, completed = %', v_course_id, v_enrollment_id, total_assignments, completed_assignments;

    -- 6. Issue certificate if all assignment completed
    IF total_assignments > 0 AND completed_assignments = total_assignments THEN
        INSERT INTO certificate(enrollment_id, certificate_url)
        VALUES (
            v_enrollment_id,
            'https://example.com/certificate/' || v_enrollment_id
        );
        RAISE NOTICE 'Certificate issued for enrollment_id %', v_enrollment_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------
-- TRIGGER: On Submissions
------------------------------------------------------
CREATE TRIGGER trigger_issue_certificate
AFTER INSERT ON submission
FOR EACH ROW
EXECUTE FUNCTION issue_certificate_if_complete();


------------------------------------------------------
-- FUNCTION: Audit Certificate Insertions
------------------------------------------------------
CREATE OR REPLACE FUNCTION audit_certificate_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO certificate_audit (enrollment_id, certificate_url, action)
    VALUES (NEW.enrollment_id, NEW.certificate_url, 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------
-- TRIGGER: On Certificates Table
------------------------------------------------------
CREATE TRIGGER trigger_certificate_audit
AFTER INSERT ON certificate
FOR EACH ROW
EXECUTE FUNCTION audit_certificate_changes();

------------------------------------------------------
-- METHODS FOR CHECK TRIGGER AND FUNCTION CREATED OR NOT
------------------------------------------------------
-- Method 1: Check using pg_trigger (most direct)
SELECT * FROM pg_trigger 
WHERE tgname = 'trigger_issue_certificate';

-- Method 2: Check using information_schema
SELECT * FROM information_schema.triggers 
WHERE trigger_name = 'trigger_issue_certificate';

-- Method 3: List all triggers on the submissions table
SELECT tgname AS trigger_name
FROM pg_trigger t
JOIN pg_class c ON t.tgrelid = c.oid
WHERE c.relname = 'submissions' AND NOT t.tgisinternal;

-- Method 4: Comprehensive trigger information
SELECT 
    event_object_table AS table_name,
    trigger_name,
    action_timing AS timing,
    event_manipulation AS event,
    action_statement AS definition
FROM information_schema.triggers
WHERE trigger_name = 'trigger_issue_certificate';

-- Method 5: Check if the function exists
SELECT * FROM pg_proc WHERE proname = 'issue_certificate_if_complete';

-- Method 6: Using the \d command in psql CLI
-- Run this in the psql command-line tool
-- \d submissions

------------------------------------------------------
-- TEST TRIGGERS
------------------------------------------------------
/* 
    Submit All Assignments (Trigger Will Fire) For below details
    student_id = 401,
    course_id = 753,
    assignment_ids = 111, 1236, 782(Already submitted)
    enrollment_id = 2979
*/
INSERT INTO submission (assignment_id, student_id, file_url, submission_date) 
VALUES
--(111, 401, 'https://example.com/submissions/submission111.pdf', CURRENT_DATE)
(1236, 401, 'https://example.com/submissions/submission1236.pdf', CURRENT_DATE)
ON CONFLICT (assignment_id, student_id) DO NOTHING;

-- Check Certificates and certificate_audit table
SELECT * FROM certificate_audit;
SELECT * FROM certificate WHERE enrollment_id=2979; -- 1999
DELETE from certificate WHERE enrollment_id=2979;
SELECT * FROM course;
SELECT * from submission WHERE student_id=401; --3002
SELECT * from enrollment WHERE course_id=753 AND student_id = 401;
SELECT COUNT(id), course_id from assignment GROUP BY  (course_id);
SELECT * FROM assignment WHERE course_id = 753
------------------------------------------------------------------------------
-- Reseed submission.id Sequence
-- To solve duplicate key value violates unique constraint "submission_pkey"
------------------------------------------------------------------------------
SELECT setval(pg_get_serial_sequence('submission', 'id'), COALESCE(MAX(id), 1), true) FROM submission;

/* duplicate key value violates unique constraint "certificate_pkey" */
SELECT setval(pg_get_serial_sequence('certificate', 'id'), COALESCE(MAX(id), 1), true) FROM certificate;
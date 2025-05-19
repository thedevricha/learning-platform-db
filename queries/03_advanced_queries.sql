-- =====================
-- Transaction
-- =====================
/* GOAL:
- Safely enroll a student into a course AND record a payment. If one fails, both should fail.
*/
BEGIN;
    -- 1. Enroll student
    INSERT INTO enrollment (student_id, course_id, enrollment_date)
    VALUES (101, 10, CURRENT_DATE);

    -- 2. Add payment record
    -- Fail (e.g. amount is NULL, violates NOT NULL)
    INSERT INTO payment (student_id, course_id, amount, payment_date)
    VALUES (101, 10, NULL, CURRENT_TIMESTAMP);
-- This line won't be reached if there's an error above
COMMIT;

-- Instead, It’ll ROLLBACK
ROLLBACK;

-- =====================
-- Transaction with SAVEPOINT
-- =====================
-- Enroll Student + Optional Welcome Review
BEGIN;

    -- 1. Enroll student
    INSERT INTO enrollment (student_id, course_id, enrollment_date)
    VALUES (101, 3, CURRENT_DATE);

    -- 2. Add payment record
    -- Fail (e.g. amount is NULL, violates NOT NULL)
    INSERT INTO payment (student_id, course_id, amount, payment_date)
    VALUES (101, 3, 300.67, CURRENT_TIMESTAMP);

    -- SAVEPOINT after critical steps
    SAVEPOINT after_enroll_and_pay;

    -- Step 3: Try optional welcome review (e.g., new student writes something)
    -- Let's simulate failure (e.g., invalid rating)
    INSERT INTO review (student_id, course_id, rating, comment, review_date)
    VALUES (101, 3, 2, 'Excited to start!', CURRENT_DATE);  -- rating should be 1–5

    -- Now we realize the above insert failed due to a constraint

    -- Recover:
    ROLLBACK TO SAVEPOINT after_enroll_and_pay;

-- Proceed without the review
COMMIT;

SELECT setval(pg_get_serial_sequence('review', 'id'), COALESCE(MAX(id), 1), true) FROM review;
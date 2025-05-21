/* NOTE: RUN ALL QUERIES IN ONE GO */
-- Simulate student access
SET ROLE student;
SELECT session_user, current_user;

-- Should succeed
SELECT * FROM course;
INSERT INTO enrollment (student_id, course_id, enrollment_date)
VALUES (3, 1, CURRENT_DATE);

INSERT INTO submission (assignment_id, student_id, content, submitted_at)
VALUES (1, 3, 'My answer', NOW());

-- Should fail
DELETE FROM lesson WHERE id = 1;
UPDATE course SET title = 'Malicious Update' WHERE id = 1;

RESET ROLE;

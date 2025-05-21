/* NOTE: RUN ALL QUERIES IN ONE GO */
-- Simulate instructor access
SET ROLE instructor;
SELECT session_user, current_user;

-- Should succeed
SELECT * FROM course;
INSERT INTO course (title, description, instructor_id) VALUES ('New Course', 'Test Desc', 2);
UPDATE course SET title = 'Updated' WHERE id = 2;

-- Read submissions
SELECT * FROM submission;

-- Should fail (not allowed to delete courses)
DELETE FROM course WHERE id = 2;

RESET ROLE;

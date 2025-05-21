/* NOTE: RUN ALL QUERIES IN ONE GO */
-- Simulate admin access
SET ROLE admin;
SELECT current_user;

-- Should succeed
SELECT * FROM course;
INSERT INTO course (title, description, instructor_id) VALUES ('Test Course', 'Demo', 1);
UPDATE course SET title = 'Updated Title' WHERE id = 1;
DELETE FROM course WHERE id = 1;

RESET ROLE;

------------------------------------------------------------------------------------------
-- Managing user privileges
------------------------------------------------------------------------------------------
/* GOAL:
- Admin has full access to everything.
- Instructor can manage courses and lessons.
- Student can only view course content and submit assignments — nothing more.
*/
-- Create roles with passwords (can be edited as needed)
CREATE ROLE admin LOGIN PASSWORD 'admin123';
CREATE ROLE instructor LOGIN PASSWORD 'instructor123';
CREATE ROLE student LOGIN PASSWORD 'student123';

-- Admin gets full access
GRANT ALL PRIVILEGES ON DATABASE db_learning_platform TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Instructor gets access to manage course-related content
GRANT SELECT, INSERT, UPDATE, DELETE ON course TO instructor;
GRANT SELECT, INSERT, UPDATE, DELETE ON lesson TO instructor;
GRANT SELECT, INSERT, UPDATE, DELETE ON assignment TO instructor;
GRANT SELECT ON submission TO instructor;

-- Student can view courses, enroll, and submit assignments
GRANT SELECT ON course TO student;
GRANT SELECT ON lesson TO student;
GRANT INSERT ON enrollment TO student;
GRANT INSERT, SELECT ON submission TO student;

-- Optionally revoke write permissions to secure data further
REVOKE UPDATE, DELETE ON course FROM student;
REVOKE INSERT, UPDATE, DELETE ON lesson FROM student;
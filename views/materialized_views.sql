------------------------------------------------------------------------------------
-- Materialized View for Students Enrolled per Course
------------------------------------------------------------------------------------
/* Create a view that shows each course title and how many students are enrolled — and refresh it only when needed. */

/* Step 1: Create the Materialized View */
CREATE MATERIALIZED VIEW course_enrollments_summary AS
SELECT
    c.id AS course_id,
    c.title,
    COUNT(e.student_id) AS student_count
FROM course c
LEFT JOIN enrollment e ON c.id = e.course_id
GROUP BY c.id, c.title;

/* Step 2: Query It Like a Table */
SELECT * FROM course_enrollments_summary ORDER BY student_count DESC;

/* Step 3: Refresh It When Data Changes */
REFRESH MATERIALIZED VIEW course_enrollments_summary;
/* 
    Methods for refresh data change:
    1. Manually (in admin UI)
    2. On a schedule (via cron job)
    3. With triggers (on INSERT to enrollments) 
*/

/* Step 4 (Optional): Add Indexes for Even Faster Queries */
CREATE INDEX idx_course_enrollments_summary_course_id 
ON course_enrollments_summary (course_id);

------------------------------------------------------------------------------------
-- Materialized View for Course Dashboard
------------------------------------------------------------------------------------
/* build a dashboard-style Materialized View that combines:
    - Course title
    - Average rating
    - Total number of enrolled students 
*/
/* Step 1: Create the Materialized View */
CREATE MATERIALIZED VIEW course_dashboard_summary AS
SELECT 
  c.id AS course_id,
  c.title,
  ROUND(AVG(r.rating), 2) AS average_rating,
  COUNT(e.student_id) AS enrolled_students
FROM course c
LEFT JOIN review r ON c.id = r.course_id
LEFT JOIN enrollment e ON c.id = e.course_id
GROUP BY c.id, c.title;

/* Step 2: Query the Dashboard View */
SELECT * FROM course_dashboard_summary ORDER BY enrolled_students DESC;

/* Step 3: Refresh the View When Needed */
REFRESH MATERIALIZED VIEW course_dashboard_summary;
/*  
Automate Refresh with:
    - Scheduled tasks (e.g., cron or pg_cron)
    - Triggers (more advanced)
    - Manual refresh button in your admin panel (if you connect to a UI)
*/

/* Step 4 (Optional): Add Index for Fast Filtering */
CREATE INDEX idx_course_dashboard_course_id ON course_dashboard_summary (course_id);

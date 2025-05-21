-- =====================
-- VIEWS
-- =====================
/* GOAL:
    Create a view that shows the average rating for each course along with the course title and instructor name.
*/
-- Step 1: Define the View
CREATE OR REPLACE VIEW course_average_ratings AS
SELECT 
    c.id AS course_id,
    c.title AS course,
    u.name AS instructor,
    AVG(r.rating) AS average_rating
FROM course c
JOIN instructor i ON c.instructor_id = i.id
JOIN users u ON u.id = i.user_id
LEFT JOIN review r ON c.id = r.course_id
GROUP BY c.id, c.title, u.name;

-- Step 2: Query the View
SELECT * from course_average_ratings;

/* Alter operation on VIEW */
ALTER VIEW course_average_ratings RENAME COLUMN instructor to instructor_name;
ALTER VIEW course_average_ratings RENAME TO course_average_ratings_v2;
ALTER VIEW course_average_ratings_v2 RENAME TO course_average_ratings;

/* DROP View */
DROP VIEW course_average_ratings;
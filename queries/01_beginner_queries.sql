-- =====================
-- Beginner Queries (10 Tasks)
-- Focus: SELECT, WHERE, JOIN, ORDER BY, GROUP BY, LIMIT
-- =====================



/* Select All data from Tables */
SELECT * FROM users;
SELECT * FROM instructor;
SELECT * FROM student;
SELECT * FROM course_category;
SELECT * FROM course;
SELECT * FROM lesson;
SELECT * FROM assignment;
SELECT * FROM submission;
SELECT * FROM enrollment;
SELECT * FROM payment;
SELECT * FROM certificate;
SELECT * FROM review;



/* 1. List all students with their user information. 
    - Return student ID, name, email, and date of birth.
*/
SELECT
    s.user_id AS student_id,
    u.name,
    u.email,
    s.date_of_birth
FROM student s
JOIN users u
ON s.user_id = u.id

/* 2. Find all courses created by a specific instructor.
    - Given an instructor’s name (e.g., "Amit Sharma"), list course title, price, and created_at.
*/
SELECT 
    c.instructor_id,
    u.name AS instructor_name,
    c.title AS course
FROM course c
JOIN instructor i
ON c.instructor_id = i.id
LEFT JOIN users u
ON i.user_id = u.id
WHERE u.name = 'Chelsey Fox'

/* 3. Show all lessons under a given course title.
    - List lesson titles and lesson order for the course that contain word "Advanced" at the starting of title.
*/
SELECT
    l.course_id,
    c.title AS course,
    l.title AS lesson,
    l.lesson_order
FROM lesson l 
JOIN course c
ON c.id = l.course_id
WHERE c.title LIKE 'Advance%'
ORDER BY l.course_id DESC

/* 4. List students enrolled in a specific course.
    - For course ID 3, return student names and enrollment date.
*/
SELECT 
    e.course_id,
    u.name AS student_name,
    e.enrollment_date
FROM enrollment e
JOIN student s
ON e.student_id = s.id
LEFT JOIN users u
ON s.user_id = u.id
WHERE e.course_id = 3

/* 5. Retrieve all assignments and their due dates for a course.
    - For course titled contain "Programmable" word, list assignment titles and due dates.
*/
SELECT 
    a.title,
    a.due_date
FROM assignment a
JOIN course c
ON a.course_id = c.id
WHERE c.title LIKE '%Programmable%'
ORDER BY a.id
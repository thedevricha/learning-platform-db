-- =====================
-- Beginner Queries (10 Tasks)
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
JOIN users u ON s.user_id = u.id

/* 2. Find all courses created by a specific instructor.
    - Given an instructor’s name (e.g., "Chelsey Fox"), list course title, price, and created_at.
*/
SELECT 
    c.title AS course_title,
    c.price,
    c.created_at
FROM course c
JOIN instructor i ON c.instructor_id = i.id
JOIN users u ON i.user_id = u.id
WHERE u.name = 'Chelsey Fox';


/* 3. Show all lessons under a given course title.
    - List lesson titles and lesson order for the course that contain word "Advanced" at the starting of title.
*/
SELECT
    l.title AS lesson,
    l.lesson_order
FROM lesson l 
JOIN course c ON c.id = l.course_id
WHERE c.title LIKE 'Advanced%'
ORDER BY l.course_id DESC

/* 4. List students enrolled in a specific course.
    - For course ID 3, return student names and enrollment date.
*/
SELECT 
    u.name AS student_name,
    e.enrollment_date
FROM enrollment e
JOIN student s ON e.student_id = s.id
JOIN users u ON s.user_id = u.id
WHERE e.course_id = 3

/* 5. Retrieve all assignments and their due dates for a course.
    - For course titled contain "programmable" word, list assignment titles and due dates.
*/
SELECT 
    a.title,
    a.due_date
FROM assignment a
JOIN course c ON a.course_id = c.id
WHERE LOWER(c.title) LIKE '%programmable%'
ORDER BY a.due_date

/* 
6. Get all reviews for a course with rating ≥ 4.
    - Show student names, rating, and comment text.
*/
SELECT 
    u.name AS student_name,
    r.rating,
    r.comment
FROM review r
JOIN course c ON r.course_id = c.id
JOIN student s ON r.student_id = s.id
JOIN users u ON s.user_id = u.id
WHERE r.rating >= 4
ORDER BY r.rating DESC

/* 
7. Find all submissions made by a student.
    - For student ID 2, show assignment title, submission date, and file URL.
*/
SELECT 
    s.student_id,
    a.title AS assignment,
    s.submission_date,
    s.file_url
FROM submission s
JOIN assignment a ON s.assignment_id = a.id
WHERE s.student_id IN (2,45,32,56)
ORDER BY s.student_id

/* 
8. List courses along with their category name.
    - Return course title, category name, and price.
*/
SELECT 
    c.title AS courses,
    cc.name AS category,
    c.price
FROM course c
JOIN course_category cc ON c.category_id = cc.id

/* 
9. List payments made by a specific student.
    - For student ID 4, return course titles, amounts paid, and payment dates.
*/
SELECT
    c.title AS courses,
    p.amount AS amount_paid,
    p.payment_date
FROM payment p
JOIN course c
ON p.course_id = c.id
WHERE p.student_id = 4

/* 
10. Get all certificates issued in the last 30 days.
    - Return student name, course title, and issued_date.
*/
SELECT
    u.name AS student_name,
    c.title AS course,
    cert.issued_date
FROM certificate cert
JOIN enrollment e ON cert.enrollment_id = e.id
JOIN student s ON e.student_id = s.id
JOIN course c ON e.course_id = c.id
JOIN users u ON s.user_id = u.id
WHERE
    cert.issued_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY 
    cert.issued_date DESC;
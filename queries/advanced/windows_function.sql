-- =====================
-- Window Functions
-- =====================
/* 1. List each student with their total payments and rank them from highest to lowest payer. */
WITH student_totals AS (
    SELECT 
        s.id AS student_id,
        u.name AS student_name,
        COALESCE(SUM(p.amount), 0) AS total_payments
    FROM student s
    JOIN users u ON s.user_id = u.id
    LEFT JOIN payment p ON s.id = p.student_id
    GROUP BY s.id, u.name
)
SELECT *,
    RANK() OVER(ORDER BY total_payments DESC) AS rank_high_to_low
FROM student_totals;

/* 2. List lessons with a row number within each course to show lesson order. */
SELECT 
    c.title AS course,
    l.title AS lesson,
    RANK() OVER(PARTITION BY l.course_id ORDER BY l.lesson_order) AS lesson_order
FROM lesson l
JOIN course c
ON l.course_id = c.id

/* 3.  For each student, find their most recent assignment submission. */
WITH submission_stats AS (
    SELECT 
        s.student_id,
        s.submission_date,
        s.assignment_id,
        ROW_NUMBER() OVER(PARTITION BY s.student_id ORDER BY s.submission_date DESC) AS rn
    FROM submission s
)
SELECT 
    u.name AS student_name,
    a.title AS assignment_title,
    ss.submission_date
FROM submission_stats ss
JOIN student st ON ss.student_id = st.id
JOIN users u ON st.user_id = u.id
JOIN assignment a ON ss.assignment_id = a.id
WHERE ss.rn = 1;

/* 4. List each course review, and also show the course’s average rating next to each review */
SELECT 
    c.id AS course_id,
    c.title AS course,
    r.student_id,
    r.rating,
    ROUND(AVG(r.rating) OVER(PARTITION BY course_id), 2) AS avg_ratings
FROM review r
JOIN course c
ON r.course_id = c.id
ORDER BY avg_ratings DESC

/* 5. For Each Instructor, Show Their Courses and How Popular Each Course Is Compared to Their Others */
WITH student_enrolled AS (
    SELECT 
        e.course_id,
        COUNT(e.student_id) AS total_students
    FROM enrollment e
    GROUP BY e.course_id
)
SELECT 
    c.id AS course_id,
    c.title AS course_title,
    u.name AS instructor,
    COALESCE(se.total_students, 0) AS total_students,
    RANK() OVER(PARTITION BY c.instructor_id ORDER BY COALESCE(se.total_students, 0) DESC) AS rank
FROM course c
LEFT JOIN student_enrolled se ON c.id = se.course_id
JOIN users u ON c.instructor_id = u.id
ORDER BY u.name, rank;
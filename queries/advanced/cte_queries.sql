-- =====================
-- CTEs (COMMON TABLE EXPRESSIONS)
-- =====================
/* 1. Show the average payment made by each student, and list only those who paid more than the average of all students. */
WITH student_total_payment AS (
    SELECT 
    student_id,
    SUM(amount) AS total_payment
    FROM payment
    GROUP BY student_id
),
overall_avg_payment AS (
    SELECT 
    ROUND(AVG(total_payment),2) AS avg_payment
    FROM student_total_payment
)
SELECT 
    stp.student_id,
    u.name,
    stp.total_payment,
    oap.avg_payment
FROM student_total_payment stp
JOIN overall_avg_payment oap ON true
JOIN student s ON stp.student_id = s.id
JOIN users u ON s.user_id = u.id
WHERE stp.total_payment > oap.avg_payment
ORDER BY stp.total_payment DESC;

/* 2. Find all students who enrolled in courses but never submitted any assignments. */
-- Step 1: Get all students who enrolled in at least one course
WITH enrolled_students AS (
    SELECT 
        DISTINCT student_id
    FROM enrollment
),
-- Step 2: Get all students who submitted at least one assignment
students_who_submitted AS (
    SELECT 
        DISTINCT student_id
    FROM submission
)
-- Step 3: Select enrolled students who never submitted any assignment
SELECT u.name AS student_name
FROM enrolled_students e
LEFT JOIN students_who_submitted s ON e.student_id = s.student_id
JOIN student st ON e.student_id = st.id
JOIN users u ON st.user_id = u.id
WHERE s.student_id IS NULL
ORDER BY u.name;

/* 3. List all courses that have more than 2 lessons but no assignments. Show the course title and number of lessons. */
-- Step 1: Get all courses that have more than 2 lessons
WITH courses_with_lessons AS (
    SELECT 
        course_id,
        COUNT(id) AS total_lesson
    FROM lesson
    GROUP BY course_id
    HAVING COUNT(id) > 2
),
-- Step 2: Get all course IDs that have at least one assignment.
courses_with_assignments AS (
    SELECT 
        course_id
    FROM assignment
    GROUP BY course_id
    HAVING COUNT(id) >= 1
)
-- Step 3: Now select courses from the first CTE that are not in the second CTE.
SELECT 
    cl.course_id,
    c.title,
    cl.total_lesson
FROM courses_with_lessons cl
LEFT JOIN courses_with_assignments ca 
ON cl.course_id = ca.course_id
JOIN course c 
ON cl.course_id = c.id
WHERE ca.course_id IS NULL
ORDER BY cl.total_lesson DESC

/* 4. Find the instructors whose average course rating is higher than the average rating of all courses in the platform. */
-- Step 1: Get average rating per course
WITH course_avg_rating AS (
    SELECT 
        course_id, 
        ROUND(AVG(rating), 2) AS avg_rating
    FROM review
    GROUP BY course_id
),
-- Step 2: Calculate overall platform-wide average rating
platform_avg_rating AS (
    SELECT ROUND(AVG(avg_rating), 2) AS platform_avg
    FROM course_avg_rating
),
-- Step 3: Join course_avg_rating with courses and instructors to get each instructor's average course rating
instructor_avg_rating AS (
    SELECT 
        c.instructor_id,
        ROUND(AVG(car.avg_rating), 2) AS instructor_avg
    FROM course c
    JOIN course_avg_rating car ON c.id = car.course_id
    GROUP BY c.instructor_id
)
-- Step 4: Compare instructor’s average with platform average
SELECT 
    u.name AS instructor_name,
    iar.instructor_avg,
    par.platform_avg
FROM instructor_avg_rating iar
JOIN users u ON iar.instructor_id = u.id
CROSS JOIN platform_avg_rating par
WHERE iar.instructor_avg > par.platform_avg
ORDER BY iar.instructor_avg DESC;

/* 5. Find students who have enrolled in at least 2 different courses and submitted to at least 2 different assignments. */
-- Step 1: Get students with ≥ 2 course enrollments
WITH enrolled_students AS (
    SELECT 
        student_id
    FROM enrollment
    GROUP BY student_id
    HAVING COUNT(DISTINCT course_id) >= 2
),
-- Step 2: Get students with ≥ 2 assignment submissions
submitting_students AS (
    SELECT 
        student_id
    FROM submission
    GROUP BY student_id
    HAVING COUNT(DISTINCT assignment_id) >= 2
)
-- Step 3: Find students who are in both groups and show their names
SELECT 
    u.name AS student_name
FROM enrolled_students es
JOIN submitting_students ss ON es.student_id = ss.student_id
JOIN student s ON es.student_id = s.id
JOIN users u ON s.user_id = u.id
ORDER BY student_name;

-- Generate Users
COPY users
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\users.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Instructors
COPY instructor
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\instructor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Students
COPY student
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\student.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Course Categories
COPY course_category
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\course_category.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Courses
COPY course
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\course.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Enrollment
COPY enrollment
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\enrollment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Lessons
COPY lesson
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\lesson.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Assignments
COPY assignment
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\assignment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Submissions (only for past due dates and enrolled students)
COPY submission
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\submission.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Reviews
COPY review
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\review.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Payments
COPY payment
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\payment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Certificate
COPY certificate
FROM 'C:\wamp64\www\learning\learning-platform-db\csv_files\certificate.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

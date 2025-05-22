-- Generate Users
COPY users
FROM 'csv_files\users.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Instructors
COPY instructor
FROM 'csv_files\instructor.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Students
COPY student
FROM 'csv_files\student.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Course Categories
COPY course_category
FROM 'csv_files\course_category.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Courses
COPY course
FROM 'csv_files\course.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Enrollment
COPY enrollment
FROM 'csv_files\enrollment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Lessons
COPY lesson
FROM 'csv_files\lesson.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Assignments
COPY assignment
FROM 'csv_files\assignment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Submissions (only for past due dates and enrolled students)
COPY submission
FROM 'csv_files\submission.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Reviews
COPY review
FROM 'csv_files\review.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Payments
COPY payment
FROM 'csv_files\payment.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Certificate
COPY certificate
FROM 'csv_files\certificate.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Users
COPY users
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\users.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Instructors
COPY instructors
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\instructors.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Students
COPY students
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\students.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Course Categories
COPY course_categories
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\course_categories.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Courses
COPY courses
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\courses.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Enrollment
COPY enrollments
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\enrollments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Lessons
COPY lessons
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\lessons.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Assignments
COPY assignments
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\assignments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Submissions (only for past due dates and enrolled students)
COPY submissions
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\submissions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Reviews
COPY reviews
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\reviews.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Payments
COPY payments
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\payments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Generate Certificate
COPY certificates
FROM 'C:\wamp64\www\learning\e-learnDB\csv_files\certificates.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

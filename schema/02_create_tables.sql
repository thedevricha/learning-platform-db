-- ========================================
-- Subject: Table Creation
-- Project: Online Learning Platform
-- Author: Richa
-- DB: PostgreSQL
-- ========================================

-- Drop if exists for dev resets
DROP TABLE IF EXISTS 
    certificate_audit, certificate, submission, assignment, payment, review,
    lesson, enrollment, student, instructor, course, coursecategory, user
CASCADE;

-- =====================
-- 1. User Table
-- =====================
CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('student', 'instructor')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_role ON user(role);


-- =====================
-- 2. Instructor Table
-- =====================
CREATE TABLE instructor (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES user(id) ON DELETE CASCADE,
    bio TEXT,
    expertise_area VARCHAR(100)
);


-- =====================
-- 3. Student Table
-- =====================
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES user(id) ON DELETE CASCADE,
    date_of_birth DATE
);

CREATE INDEX idx_student_user ON student(user_id);


-- =====================
-- 4. course Category Table
-- =====================
CREATE TABLE course_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);


-- =====================
-- 5. Course Table
-- =====================
CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    instructor_id INT NOT NULL REFERENCES instructor(id) ON DELETE CASCADE,
    category_id INT REFERENCES course_category(id),
    price DECIMAL(10,2) DEFAULT 0.00 CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_course_instructor ON course(instructor_id);
CREATE INDEX idx_course_category ON course(category_id);


-- =====================
-- 6. Lesson Table
-- =====================
CREATE TABLE lesson (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES course(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    lesson_order INT NOT NULL
);

CREATE INDEX idx_lesson_course ON lesson(course_id);


-- =====================
-- 7. Enrollment Table
-- =====================
CREATE TABLE enrollment (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES course(id) ON DELETE CASCADE,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id)
);

CREATE INDEX idx_enrollment_student ON enrollment(student_id);
CREATE INDEX idx_enrollment_course ON enrollment(course_id);


-- =====================
-- 8. Assignment Table
-- =====================
CREATE TABLE assignment (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES course(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    due_date DATE
);

CREATE INDEX idx_assignment_course ON assignment(course_id);


-- =====================
-- 9. Submission Table
-- =====================
CREATE TABLE submission (
    id SERIAL PRIMARY KEY,
    assignment_id INT NOT NULL REFERENCES assignment(id) ON DELETE CASCADE,
    student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
    file_url TEXT NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(assignment_id, student_id)
);

CREATE INDEX idx_submission_assignment ON submission(assignment_id);


-- =====================
-- 10. Review Table
-- =====================
CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES course(id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id)
);

CREATE INDEX idx_review_course ON review(course_id);
CREATE INDEX idx_review_student ON review(student_id);


-- =====================
-- 11. Payment Table
-- =====================
CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES course(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_payment_course ON payment(course_id);
CREATE INDEX idx_payment_student ON payment(student_id);


-- =====================
-- 12. Certificate Table
-- =====================
CREATE TABLE certificate (
    id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL REFERENCES enrollment(id) ON DELETE CASCADE,
    certificate_url TEXT NOT NULL,
    issued_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(enrollment_id)
);

CREATE INDEX idx_certificate_enrollment ON certificate(enrollment_id);


-- =====================
-- 13. Certificate Audit Table (for trigger logging)
-- =====================
CREATE TABLE certificate_audit (
    id SERIAL PRIMARY KEY,
    enrollment_id INT,
    certificate_url TEXT,
    action TEXT CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
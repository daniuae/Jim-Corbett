
-- =====================================================
-- DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS LEARNING_DB;

USE LEARNING_DB;

-- =====================================================
-- 1. SUBJECTS
-- =====================================================

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100)
);

-- =====================================================
-- 2. INSTRUCTORS
-- =====================================================

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100)
);

-- =====================================================
-- 3. COURSES
-- =====================================================

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_id INT,
    subject_id INT,
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id) REFERENCES Instructors (instructor_id),
    CONSTRAINT fk_course_subject FOREIGN KEY (subject_id) REFERENCES Subjects (subject_id)
);

-- =====================================================
-- 4. ENROLLMENTS
-- =====================================================

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    students_count INT,
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id) REFERENCES Courses (course_id)
);

-- =====================================================
-- INSERT SUBJECTS
-- =====================================================

INSERT INTO
    Subjects (subject_id, subject_name)
VALUES (1, 'Data Science'),
    (2, 'Web Dev');

-- =====================================================
-- INSERT INSTRUCTORS
-- =====================================================

INSERT INTO
    Instructors (
        instructor_id,
        instructor_name
    )
VALUES (1, 'John Doe'),
    (2, 'Sarah Lee'),
    (3, 'Adam White'),
    (4, 'Alice Green'),
    (5, 'David Park');

-- =====================================================
-- INSERT COURSES
-- =====================================================

INSERT INTO
    Courses (
        course_id,
        course_name,
        instructor_id,
        subject_id
    )
VALUES (101, 'Python for DS', 1, 1),
    (102, 'ML Basics', 2, 1),
    (103, 'Deep Learning', 3, 1),
    (104, 'HTML & CSS', 4, 2),
    (
        105,
        'JavaScript Basics',
        5,
        2
    );

-- =====================================================
-- INSERT ENROLLMENTS
-- =====================================================

INSERT INTO
    Enrollments (
        enrollment_id,
        course_id,
        students_count
    )
VALUES (201, 101, 500),
    (202, 102, 450),
    (203, 103, 450),
    (204, 104, 300),
    (205, 105, 200);

-- =====================================================
--
-- =====================================================

-- Verify the Four-Table Relationship
SELECT s.subject_name, i.instructor_name, c.course_name, e.students_count
FROM
    Subjects s
    JOIN Courses c ON s.subject_id = c.subject_id
    JOIN Instructors i ON c.instructor_id = i.instructor_id
    JOIN Enrollments e ON c.course_id = e.course_id
ORDER BY s.subject_name, i.instructor_name;

SELECT
    s.subject_name,
    i.instructor_name,
    MAX(e.students_count) AS max_course_enrollments,
    RANK() OVER (
        PARTITION BY
            s.subject_id
        ORDER BY MAX(e.students_count) DESC
    ) AS popularity_rank
FROM
    subjects s
    JOIN courses c ON s.subject_id = c.subject_id
    JOIN instructors i ON c.instructor_id = i.instructor_id
    JOIN enrollments e ON c.course_id = e.course_id
GROUP BY
    s.subject_id,
    s.subject_name,
    i.instructor_id,
    i.instructor_name
ORDER BY s.subject_name, Popularity_rank;

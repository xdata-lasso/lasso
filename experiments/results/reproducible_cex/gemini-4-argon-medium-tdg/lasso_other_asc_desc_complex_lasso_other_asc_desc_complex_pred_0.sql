-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (semester DESC, grade ASC, enrollment_id ASC) and LIMIT 5 boundary (having > 5 rows).
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Bob', 'Jones', 2021, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Charlie', 'Brown', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Diana', 'Prince', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'Evan', 'Wright', 2023, 'Biology');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (6, 'Fiona', 'Gallagher', 2021, 'Chem');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (7, 'George', 'Clark', 2022, 'History');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (10, 1, 101, '2023-Spring', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (20, 2, 101, '2023-Spring', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (15, 3, 101, '2023-Spring', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (30, 4, 101, '2022-Fall', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 5, 101, '2022-Fall', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (25, 6, 101, '2022-Fall', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (40, 7, 101, '2021-Spring', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(3,)
(2,)
(1,)
(4,)
(6,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester ASC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(7,)
(4,)
(6,)
(5,)
(3,)
*/
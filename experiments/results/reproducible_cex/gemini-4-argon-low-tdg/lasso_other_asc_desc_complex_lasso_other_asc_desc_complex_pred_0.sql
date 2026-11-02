-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering, tie-breaking across all three ORDER BY columns (semester DESC, grade ASC, enrollment_id ASC), and the LIMIT 5 boundary (7 rows total).
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (101, 'Alice', 'Smith', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (102, 'Bob', 'Jones', 2021, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (103, 'Charlie', 'Brown', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (104, 'Diana', 'Prince', 2020, 'History');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (105, 'Evan', 'Wright', 2023, 'Biology');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (106, 'Fiona', 'Gallagher', 2021, 'Art');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (107, 'George', 'Clark', 2022, 'Chemistry');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (10, 101, 1, '2023-Spring', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (20, 102, 1, '2023-Spring', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 103, 1, '2023-Spring', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (15, 104, 1, '2023-Fall', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (25, 105, 1, '2023-Fall', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (30, 106, 1, '2022-Winter', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 107, 1, '2022-Fall', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(103,)
(102,)
(101,)
(105,)
(104,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester ASC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(107,)
(106,)
(105,)
(104,)
(103,)
*/
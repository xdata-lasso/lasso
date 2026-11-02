-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Charlie', 'Brown', 2022, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (103, 'PH101', 'Physics I', 4, 'Physics');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 103, 'Fall 2022', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 1, 103, 'Spring 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 1, 103, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (4, 1, 103, 'Spring 2024', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 1, 103, 'Fall 2024', 'F');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (6, 1, 103, 'Spring 2025', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'B' THEN 3 ELSE 0 END FROM Enrollments;

/*
Gold Result:
(4,)
(4,)
(3,)
(3,)
(0,)
(0,)
*/

-- Prediction Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'C' THEN 3 ELSE 0 END FROM Enrollments;

/*
Prediction Result:
(4,)
(4,)
(0,)
(0,)
(0,)
(0,)
*/
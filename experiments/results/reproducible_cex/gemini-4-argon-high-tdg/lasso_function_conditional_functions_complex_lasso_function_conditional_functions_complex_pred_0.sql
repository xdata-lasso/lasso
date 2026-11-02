-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Charlie', 'Brown', 2020, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Dana', 'White', 2023, 'History');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (201, 'PH101', 'Mechanics', 4, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (202, 'HI101', 'World History', 3, 'History');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 201, 'Fall 2020', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 1, 202, 'Fall 2020', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 2, 201, 'Spring 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (4, 2, 202, 'Spring 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 1, 201, 'Fall 2023', NULL);
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
*/
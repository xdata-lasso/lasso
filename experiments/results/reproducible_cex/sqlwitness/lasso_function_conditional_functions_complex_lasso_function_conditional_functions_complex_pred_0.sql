-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (course_id, course_code, course_name, credits, department) VALUES (3, 'default1', 'B', NULL, 'default1'), (5, NULL, 'default1', -1, 'B');
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (-1, NULL, 'default2', NULL, NULL);
INSERT INTO enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, NULL, 3, 'B', 'default1'), (5, -1, NULL, 'default1', 'B'), (3, -1, NULL, 'B', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'B' THEN 3 ELSE 0 END FROM Enrollments;

/*
Gold Result:
(0,)
(0,)
(3,)
*/

-- Prediction Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'C' THEN 3 ELSE 0 END FROM Enrollments;

/*
Prediction Result:
(0,)
(0,)
(0,)
*/
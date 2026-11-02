-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO professors (professor_id, name, department, hire_date, salary) VALUES (0, 'default1', NULL, NULL, NULL), (1, NULL, 'CS', '2023-01-01', NULL);
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, NULL, NULL, 1, 'default2'), (0, NULL, 'default1', NULL, NULL), (2, 'CS', NULL, NULL, NULL), (3, NULL, NULL, 1, NULL), (4, NULL, 'default2', 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'CS';

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Professors WHERE department = 'CS';

/*
Prediction Result:
(None,)
*/
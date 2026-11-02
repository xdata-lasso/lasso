-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (course_id, course_code, course_name, credits, department) VALUES (0, 'default2', 'default1', 4, 'default1'), (3, 'default1', NULL, NULL, 'default1'), (4, NULL, NULL, 3, 'default1'), (5, 'default2', NULL, 0, 'default2');
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'default1', 'default1', 4, NULL), (0, 'default2', 'default1', 3, 'default2'), (5, 'default2', 'default2', 1, 'default1'), (3, NULL, 'default1', 5, 'default2');
INSERT INTO enrollments (enrollment_id, course_id, student_id, semester, grade) VALUES (0, 0, 3, NULL, 'default1'), (5, NULL, 0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_code FROM Courses WHERE credits = 4);

/*
Prediction Result:
*/
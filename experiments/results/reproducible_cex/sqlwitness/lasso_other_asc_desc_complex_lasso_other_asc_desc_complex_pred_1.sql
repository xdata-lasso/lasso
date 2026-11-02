-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, NULL, NULL, 1, NULL), (6, 'default2', 'default1', 4, NULL), (5, NULL, NULL, 6, 'default1');
INSERT INTO enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, NULL, 'default2', 'default2'), (5, 5, NULL, 'default1', NULL), (4, 6, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(1,)
(5,)
(6,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade DESC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(1,)
(6,)
(5,)
*/
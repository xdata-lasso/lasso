-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (course_id, course_code, course_name, credits, department) VALUES (1, 'default1', NULL, NULL, 'default2'), (0, 'default2', 'default1', 0, 'default1'), (2, 'default1', 'default1', 1, 'default2'), (3, 'A_wrong', 'A', 0, 'B');
INSERT INTO enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, NULL, NULL, 'default1', 'default2'), (0, NULL, 2, 'default1', 'A'), (2, NULL, 3, 'A', 'A'), (3, NULL, 3, 'default2', 'B'), (4, NULL, 0, 'B', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'A_wrong' OR grade = 'B';

/*
Prediction Result:
(None,)
(None,)
*/
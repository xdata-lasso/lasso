-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (course_id, course_code, course_name, credits, department) VALUES (4, 'default1', 'A', 2, NULL), (3, 'default2', 'default1', 3, 'A'), (2, 'A', NULL, 1, NULL), (1, 'default2', 'default2', 4, 'default1');
INSERT INTO enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (0, NULL, 2, 'default2', 'default1'), (1, NULL, 2, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits > 3 UNION SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits > 3 INTERSECT SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Prediction Result:
*/
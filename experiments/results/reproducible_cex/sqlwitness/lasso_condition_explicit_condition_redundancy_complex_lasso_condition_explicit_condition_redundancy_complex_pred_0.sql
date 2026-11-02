-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'default2', 'default1', 2020, 'Physics'), (2019, 'A%', 'default1', 2020, 'A%'), (2020, 'default1', 'A%', 2019, 'A%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'Physics';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE major = 'Physics' AND enrollment_year = 2020 AND last_name LIKE 'A%';

/*
Prediction Result:
*/
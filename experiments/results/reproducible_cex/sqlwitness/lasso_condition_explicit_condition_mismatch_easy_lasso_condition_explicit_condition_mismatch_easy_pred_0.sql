-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (student_id, first_name, last_name, enrollment_year, major) VALUES (2021, 'default2', 'default1', 0, 'CS'), (0, 'CS', 'CS', 2023, 'CS'), (2023, 'CS', 'CS', 2022, 'CS'), (1, 'CS', 'default2', 0, 'CS'), (2022, NULL, 'default2', 2021, 'default1'), (2, 'default1', 'default2', 2022, 'default2'), (3, 'default1', 'default2', 2022, 'CS'), (4, 'default2', 'default2', 0, 'CS'), (5, 'default1', 'default2', 0, NULL), (6, 'CS', 'CS', 2022, 'default2'), (7, 'CS', NULL, NULL, 'CS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND major = 'CS';

/*
Gold Result:
('default1',)
('CS',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND first_name = 'CS';

/*
Prediction Result:
('CS',)
('CS',)
*/
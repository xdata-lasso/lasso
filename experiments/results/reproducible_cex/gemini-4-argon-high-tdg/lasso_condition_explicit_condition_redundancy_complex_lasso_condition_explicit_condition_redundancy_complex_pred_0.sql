-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Zack', 'Brown', 2021, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Alice', 'Smith', 2020, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Alice', 'Jones', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Bob', 'White', 2019, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'Charlie', 'Green', 2021, 'Mathematics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (6, 'Diana', 'Black', 2020, 'Psychology');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'Physics';

/*
Gold Result:
('Zack',)
('Alice',)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE major = 'Physics' AND enrollment_year = 2020 AND last_name LIKE 'A%';

/*
Prediction Result:
*/
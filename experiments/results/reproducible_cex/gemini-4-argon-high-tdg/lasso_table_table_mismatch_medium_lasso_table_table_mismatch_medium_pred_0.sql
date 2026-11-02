-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Zack', 'Smith', 2022, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Alice', 'Jones', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Alice', 'Brown', 2023, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Bob', 'White', 2021, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'Charlie', 'Green', 2019, 'Art');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'CS';

/*
Gold Result:
('Zack',)
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT name FROM Professors WHERE department = 'CS';

/*
Prediction Result:
*/
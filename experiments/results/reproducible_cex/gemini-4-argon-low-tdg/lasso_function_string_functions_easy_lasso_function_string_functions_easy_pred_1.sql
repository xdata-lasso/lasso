-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'alice', 'Smith', 2021, 'Computer Science');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Alice', 'Johnson', 2022, 'Mathematics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'ALICE', 'Williams', 2023, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Bob', 'Brown', 2020, 'History');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UPPER(first_name) FROM Students;

/*
Gold Result:
('ALICE',)
('ALICE',)
('ALICE',)
('BOB',)
*/

-- Prediction Query
SELECT TRIM(first_name) FROM Students;

/*
Prediction Result:
('alice',)
('Alice',)
('ALICE',)
('Bob',)
*/
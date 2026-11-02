-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Bob', 'Jones', 2021, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Charlie', 'Brown', 2022, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (10, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (20, 'MATH101', 'Calculus I', 3, 'Math');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (30, 'PHYS101', 'Physics I', 5, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (40, 'SEM101', 'Seminar', NULL, 'General');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (100, 1, 10, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (101, 2, 20, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (102, 3, 30, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (103, 2, 40, 'Fall 2023', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_code FROM Courses WHERE credits = 4);

/*
Prediction Result:
*/
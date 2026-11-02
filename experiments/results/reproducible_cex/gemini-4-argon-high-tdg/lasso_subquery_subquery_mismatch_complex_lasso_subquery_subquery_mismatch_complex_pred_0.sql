-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (101, 'Alice', 'Smith', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (102, 'Bob', 'Jones', 2022, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (103, 'Charlie', 'Brown', 2020, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (104, 'Diana', 'Prince', 2023, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (201, 'CS101', 'Intro to CS', 3, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (202, 'CS102', 'Data Structures', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (203, 'PHY101', 'Mechanics', 5, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (204, 'MATH201', 'Linear Algebra', 4, 'Math');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (301, 101, 201, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (302, 102, 202, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (303, 103, 203, 'Fall 2023', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 3);

/*
Prediction Result:
(101,)
*/
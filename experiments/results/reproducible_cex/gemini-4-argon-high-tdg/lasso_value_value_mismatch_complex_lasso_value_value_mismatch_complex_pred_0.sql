-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (10, 'Alice', 'Smith', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (20, 'Bob', 'Jones', 2022, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (30, 'Charlie', 'Brown', 2020, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (40, 'Diana', 'Prince', 2023, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (50, 'Evan', 'Wright', 2021, 'History');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (60, 'Fiona', 'Gallagher', 2022, 'Biology');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (102, 'MA101', 'Calculus I', 3, 'Math');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 10, 101, 'Fall 2022', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 20, 101, 'Fall 2022', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 30, 102, 'Fall 2022', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (4, 40, 102, 'Fall 2022', 'F');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 50, 101, 'Spring 2023', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'C' OR grade = 'D';

/*
Prediction Result:
(30,)
*/
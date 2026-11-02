-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (101, 'Alice', 'Smith', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (102, 'Bob', 'Jones', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (103, 'Carol', 'White', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (104, 'David', 'Brown', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (105, 'Eve', 'Davis', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (106, 'Frank', 'Miller', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (107, 'Grace', 'Wilson', 2021, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (201, 'CS101', 'Algorithms', 4, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (10, 107, 201, '2023-Fall', 'G');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (20, 106, 201, '2023-Fall', 'F');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (30, 105, 201, '2023-Fall', 'E');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (40, 104, 201, '2023-Fall', 'D');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (50, 103, 201, '2023-Fall', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (60, 102, 201, '2023-Fall', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (70, 101, 201, '2023-Fall', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(101,)
(102,)
(103,)
(104,)
(105,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade DESC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(107,)
(106,)
(105,)
(104,)
(103,)
*/
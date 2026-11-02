-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (101, 'Alice', 'Smith', 2020, 'Computer Science');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (102, 'Bob', 'Jones', 2021, 'Mathematics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (103, 'Carol', 'White', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (104, 'David', 'Brown', 2019, 'Biology');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (105, 'Eve', 'Davis', 2023, 'Chemistry');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (106, 'Frank', 'Miller', 2020, 'History');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (201, 'CS101', 'Intro to CS', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (202, 'MA101', 'Calculus I', 3, 'Mathematics');
INSERT INTO Professors (professor_id, name, department, hire_date, salary) VALUES (301, 'Dr. Adams', 'Computer Science', '2015-08-15', 95000.0);
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 106, 201, '2021-Fall', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 105, 202, '2021-Spring', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 104, 201, '2022-Fall', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (4, 101, 202, '2022-Spring', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 103, 201, '2023-Fall', 'D');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (6, 102, 202, '2023-Spring', 'E');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (7, 101, 201, '2024-Fall', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(101,)
(102,)
(103,)
(101,)
(104,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester ASC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(106,)
(105,)
(104,)
(101,)
(103,)
*/
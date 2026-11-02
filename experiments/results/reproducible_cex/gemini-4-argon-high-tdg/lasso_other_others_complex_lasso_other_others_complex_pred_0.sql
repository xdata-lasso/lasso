-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2022, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Algorithms', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (102, 'CS102', 'Seminar', 2, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (103, 'CS103', 'Systems', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (104, 'CS104', 'Lab', 1, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 102, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 1, 103, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 1, 104, 'Fall 2023', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits > 3 UNION SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Gold Result:
(101,)
(102,)
(103,)
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits > 3 INTERSECT SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Prediction Result:
*/
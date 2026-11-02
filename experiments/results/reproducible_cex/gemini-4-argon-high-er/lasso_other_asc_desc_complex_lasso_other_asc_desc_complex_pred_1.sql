-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'A', 'A', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'B', 'B', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'C', 'C', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'D', 'D', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'E', 'E', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (6, 'F', 'F', 2020, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Intro', 4, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 1, 'Fall2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 2, 1, 'Fall2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (3, 3, 1, 'Fall2023', 'C');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (4, 4, 1, 'Fall2023', 'D');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (5, 5, 1, 'Fall2023', 'E');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (6, 6, 1, 'Fall2023', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade DESC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(6,)
(5,)
(4,)
(3,)
(2,)
*/
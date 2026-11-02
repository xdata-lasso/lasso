-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (9, 'A12', 'A12', 12, 'A12');
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (8, 'A12', 'A12', 12, 'A12');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (12, 'A12', 'A12', 12, 'A12');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (11, NULL, 12, 'A15', 'B');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (10, NULL, 12, 'B16', 'A_wrong');
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (14, 'A12', 'A12', '1000-01-13', 12);
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (13, 'A12', 'A12', '1000-01-13', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'A_wrong' OR grade = 'B';

/*
Prediction Result:
(None,)
(None,)
*/
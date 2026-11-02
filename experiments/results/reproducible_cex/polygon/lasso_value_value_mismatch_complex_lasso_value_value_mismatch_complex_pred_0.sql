-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (9, 'B', 'B', 3110908396565426940, 'B');
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (8, 'B', 'B', 3110908396565426940, 'B');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (11, 'B', 'B', 3110908396565426940, 'B');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (10, 'B', 'B', 3110908396565426940, 'B');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (13, NULL, NULL, NULL, 'B');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (12, NULL, NULL, NULL, 'B');
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (17, 'B', 'B', '9999-12-31', 3110908396565426940);
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (16, 'B', 'B', '9999-12-31', 3110908396565426940);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'C' OR grade = 'D';

/*
Prediction Result:
*/
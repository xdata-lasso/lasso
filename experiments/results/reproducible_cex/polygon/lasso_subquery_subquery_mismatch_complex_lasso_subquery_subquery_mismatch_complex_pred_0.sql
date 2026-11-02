-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (23, '19', '19', 19, '19');
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (29, '19', '19', 19, '19');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (28, '16', '17', 3, '18');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (19, NULL, NULL, 4, NULL);
INSERT INTO "Enrollments" ("enrollment_id", "course_id", "student_id", "semester", "grade") VALUES (13, 19, 23, NULL, NULL);
INSERT INTO "Enrollments" ("enrollment_id", "course_id", "student_id", "semester", "grade") VALUES (12, 28, 29, '26', '27');
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (15, '19', '19', '1000-01-20', 19);
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (14, '19', '19', '1000-01-20', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(23,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 3);

/*
Prediction Result:
(29,)
*/
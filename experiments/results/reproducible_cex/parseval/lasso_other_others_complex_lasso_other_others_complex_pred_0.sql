-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, 'gu7v', 'e4', 1160656988, 'ia2yp');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1, '5k5swwqcgs', '9n8', 4, '4');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483647, 'hvdlttilbnpr', 'dpos', 4, 'ie5');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (2, '5s5b', 'p', 3, '02eutliqa11r');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (3, 'ytoo3o9', 'l7', NULL, 'klex14ji');

-- Inserting into table: enrollments --
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483648, -2147483648, 1, 'uzhsrwbbp6lu', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (2, -2147483648, 1, 'w6kl', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (3, -2147483648, 1, 'a9000t5c4eci', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483645, -2147483648, 1, 'e', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483644, -2147483648, 1, '6nium52zb', 'enr_f7ee54');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483643, -2147483648, 1, 'nrqrofqy', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (4, -2147483648, 2, 'au2dwyrq13', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits > 3 UNION SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Gold Result:
(-2147483647,)
(1,)
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits > 3 INTERSECT SELECT course_id FROM Enrollments WHERE grade = 'A';

/*
Prediction Result:
(1,)
*/
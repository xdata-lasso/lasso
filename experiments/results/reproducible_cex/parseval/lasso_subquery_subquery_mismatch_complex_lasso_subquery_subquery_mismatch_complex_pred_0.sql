-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1, 'rwbbp6luhvd', 'tti', -1364429300, 'nprmdposii');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1, '5k5swwqcgs', '9n8', 4, '4');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483648, 'gu7v', 'e4', 4, 'hria2ypuzhs');

-- Inserting into table: enrollments --
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (2, 1, 1, '5u', 'w6kl');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (3, 1, 1, 'a9', '00t5c4e');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483646, 1, 1, 'cigce376nium', '52zbuo4nrq');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483645, 1, 1, 'fqyp', 's5bbp02e');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483644, 1, 1, 'tliqa1', 'ryytoo3');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (4, 1, -2147483648, 'hl72klex1', 'ji7zwau2');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (5, 1, -2147483648, 'yrq13p', 'u78d99r');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (6, 1, -2147483648, 'sl0', '4');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (7, 1, -2147483648, 'p5qi2rkf9v', 'x58pz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 3);

/*
Prediction Result:
*/
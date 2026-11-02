-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, 'stu_219872', '5k5swwqcgs', 2022, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (2, 'stu_219872', '9n8', 2022, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (3, 'stu_219872', '4', 2022, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483645, 'stu_219872', 'gu7v', 1, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483644, 'stu_219872', 'e4', 2022, 'stu_b57a5a');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483643, NULL, 'hria2ypuzhs', 2022, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (4, 'rwbbp6luhvd', 'tti', 2022, NULL);

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (5, 'bnp', 'mdpos', 1, 'stu_24fbbc');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (6, 'ie5', 'nw6klf', 1, NULL);

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (7, 'a9000t5c4eci', 'gce376nium52', NULL, 'CS');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (8, 'zbuo4nrqrof', 'qyp5s5bbp0', NULL, 'stu_24fbbc');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (9, '2eutliqa11r', 'ytoo3o9', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND major = 'CS';

/*
Gold Result:
('stu_219872',)
(None,)
('stu_219872',)
('stu_219872',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE major = 'CS' AND enrollment_year = 2021;

/*
Prediction Result:
*/
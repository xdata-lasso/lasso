-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, 'hria2ypu', 'hsrwbbp', 13244799, 'hvdltt');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1, '5k5swwqcgs', 'c_s_bfe6c0', 247012447, '8c4pgu7vfe');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (3, 'rmdp', 'c_s_bfe6c0', 2026480202, 'ie5');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (2, 'gce376nium52', 'zbuo4nrqrof', 373262291, 'p5s5bbp');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (4, '5k5swwqcgs', NULL, 247012447, '8c4pgu7vfe');

-- Inserting into table: enrollments --
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483648, -2147483648, 1, 'e_s_23ca85', 'lbn');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (2, -2147483648, 1, 'e_s_23ca85', 'w6kl');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (3, -2147483648, 1, 'e_s_23ca85', 'a9000t5c4eci');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483645, -2147483648, 2, 'e_s_23ca85', '2eutliqa11r');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483644, -2147483648, 2, 'e_s_23ca85', 'ytoo3o9hl7');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483643, -2147483648, 1, NULL, '4ji7zwa');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483642, -2147483648, 1, 'e_s_23ca85', '2dwyrq13pyu7');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (4, -2147483648, 4, 'hria2ypuzhs', 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.course_name, e.semester FROM Courses AS c LEFT JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Gold Result:
('c_s_bfe6c0', None)
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('zbuo4nrqrof', 'e_s_23ca85')
('zbuo4nrqrof', 'e_s_23ca85')
('c_s_bfe6c0', None)
(None, 'hria2ypuzhs')
*/

-- Prediction Query
SELECT c.course_name, e.semester FROM Courses AS c CROSS JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Prediction Result:
('c_s_bfe6c0', None)
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('c_s_bfe6c0', 'e_s_23ca85')
('zbuo4nrqrof', 'e_s_23ca85')
('zbuo4nrqrof', 'e_s_23ca85')
(None, 'hria2ypuzhs')
*/
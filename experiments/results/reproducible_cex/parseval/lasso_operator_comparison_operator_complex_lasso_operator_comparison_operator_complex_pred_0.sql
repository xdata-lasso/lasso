-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483648, '5k5swwqcgs', 'Data', 247012447, '8c4pgu7vfe');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (2, 'hria2ypu', 'Data', 1644814318, 'sr');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (3, 'wbbp6luhvdlt', 'Data', -841692980, 'bnp');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483645, 'mdpos', 'A', -1576219117, '5u');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483644, 'w6kl', 'Data', 1620389964, '00t5c4ecigc');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (4, 'e376nium52', NULL, -443340271, 'uo4nrqrofqy');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (5, '5s5b', NULL, 2107872094, '02eutliqa11r');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (6, 'ytoo3o9', NULL, -1666765085, '72klex14ji7z');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (7, 'au2dwy', NULL, -953437896, '3pyu78d');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (8, '9rljsl0b4', NULL, 1649269347, 'p5qi2rkf9v');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (9, 'x58pz', NULL, -1529584866, 'd2');

INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (10, 'vy9uxj4', NULL, -1612443122, 'd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM Courses WHERE course_name LIKE '%Data%';

/*
Gold Result:
('Data',)
('Data',)
('Data',)
('Data',)
*/

-- Prediction Query
SELECT course_name FROM Courses WHERE course_name = '%Data%';

/*
Prediction Result:
*/
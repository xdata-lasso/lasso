-- Schema DDL
CREATE TABLE Registrations (reg_id INTEGER PRIMARY KEY, student_name TEXT(20) NOT NULL, semester TEXT(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), course_code TEXT(8));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: registrations --
INSERT INTO "registrations" ("reg_id", "student_name", "semester", "course_code") VALUES (1, 'value', 'Fall', 'reg_03d90c');

INSERT INTO "registrations" ("reg_id", "student_name", "semester", "course_code") VALUES (2, 'value', 'Fall', 'reg_03d90c');

INSERT INTO "registrations" ("reg_id", "student_name", "semester", "course_code") VALUES (3, 'value', 'Fall', 'reg_03d90c');

INSERT INTO "registrations" ("reg_id", "student_name", "semester", "course_code") VALUES (4, 'value', 'Spring', 'reg_03d90c');

INSERT INTO "registrations" ("reg_id", "student_name", "semester", "course_code") VALUES (-2147483644, 'reg_2a2b07', 'Fall', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_code FROM Registrations WHERE semester = 'Fall';

/*
Gold Result:
(None,)
('reg_03d90c',)
('reg_03d90c',)
('reg_03d90c',)
*/

-- Prediction Query
SELECT course_code FROM Registrations WHERE semester <> 'Fall';

/*
Prediction Result:
('reg_03d90c',)
*/
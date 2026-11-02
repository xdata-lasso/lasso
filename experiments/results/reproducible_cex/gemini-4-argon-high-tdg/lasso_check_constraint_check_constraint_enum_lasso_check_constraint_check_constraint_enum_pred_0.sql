-- Schema DDL
CREATE TABLE Registrations (reg_id INTEGER PRIMARY KEY, student_name TEXT(20) NOT NULL, semester TEXT(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), course_code TEXT(8));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (1, 'Alice', 'Fall', 'CS101');
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (2, 'Bob', 'Winter', 'CS102');
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (3, 'Charlie', 'Spring', 'CS103');
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (4, 'Diana', 'Summer', 'CS104');
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (5, 'Evan', NULL, 'CS105');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_code FROM Registrations WHERE semester = 'Fall';

/*
Gold Result:
('CS101',)
*/

-- Prediction Query
SELECT course_code FROM Registrations WHERE semester <> 'Fall';

/*
Prediction Result:
('CS102',)
('CS103',)
('CS104',)
*/
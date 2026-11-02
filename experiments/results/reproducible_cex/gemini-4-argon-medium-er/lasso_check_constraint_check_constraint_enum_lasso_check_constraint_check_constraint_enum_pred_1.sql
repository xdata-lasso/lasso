-- Schema DDL
CREATE TABLE Registrations (reg_id INTEGER PRIMARY KEY, student_name TEXT(20) NOT NULL, semester TEXT(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), course_code TEXT(8));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Registrations (reg_id, student_name, semester, course_code) VALUES (1, 'Alice', 'Winter', 'CS101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_code FROM Registrations WHERE semester = 'Fall';

/*
Gold Result:
*/

-- Prediction Query
SELECT course_code FROM Registrations;

/*
Prediction Result:
('CS101',)
*/
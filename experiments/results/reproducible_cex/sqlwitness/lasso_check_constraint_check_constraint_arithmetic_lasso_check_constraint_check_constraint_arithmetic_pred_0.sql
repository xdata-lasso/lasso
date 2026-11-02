-- Schema DDL
CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, credits INTEGER CHECK (credits % 3 = 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (course_id, credits) VALUES (5, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits = 3;

/*
Gold Result:
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits = 6;

/*
Prediction Result:
(5,)
*/
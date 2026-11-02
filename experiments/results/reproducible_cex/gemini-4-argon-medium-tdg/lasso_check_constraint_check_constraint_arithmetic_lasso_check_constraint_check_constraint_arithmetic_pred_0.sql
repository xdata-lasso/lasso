-- Schema DDL
CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, credits INTEGER CHECK (credits % 3 = 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Courses (course_id, credits) VALUES (101, 3);
INSERT INTO Courses (course_id, credits) VALUES (102, 6);
INSERT INTO Courses (course_id, credits) VALUES (103, 0);
INSERT INTO Courses (course_id, credits) VALUES (104, -3);
INSERT INTO Courses (course_id, credits) VALUES (105, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits = 3;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits = 6;

/*
Prediction Result:
(102,)
*/
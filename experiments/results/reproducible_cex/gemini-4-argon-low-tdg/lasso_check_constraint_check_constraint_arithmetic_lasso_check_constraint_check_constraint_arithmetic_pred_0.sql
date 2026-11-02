-- Schema DDL
CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, credits INTEGER CHECK (credits % 3 = 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive boundary values for credits (satisfying CHECK credits % 3 = 0) and NULLs, plus course_id edge cases
INSERT INTO Courses (course_id, credits) VALUES (-3, -3);
INSERT INTO Courses (course_id, credits) VALUES (0, 0);
INSERT INTO Courses (course_id, credits) VALUES (1, 3);
INSERT INTO Courses (course_id, credits) VALUES (2, 6);
INSERT INTO Courses (course_id, credits) VALUES (3, 9);
INSERT INTO Courses (course_id, credits) VALUES (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM Courses WHERE credits = 3;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT course_id FROM Courses WHERE credits = 6;

/*
Prediction Result:
(2,)
*/
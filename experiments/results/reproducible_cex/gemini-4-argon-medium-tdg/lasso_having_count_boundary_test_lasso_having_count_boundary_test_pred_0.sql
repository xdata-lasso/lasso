-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (stuid, major) VALUES (1, 101);
INSERT INTO Student (stuid, major) VALUES (2, 102);
INSERT INTO Student (stuid, major) VALUES (3, 102);
INSERT INTO Student (stuid, major) VALUES (4, 103);
INSERT INTO Student (stuid, major) VALUES (5, 103);
INSERT INTO Student (stuid, major) VALUES (6, 103);
INSERT INTO Student (stuid, major) VALUES (7, 104);
INSERT INTO Student (stuid, major) VALUES (8, 104);
INSERT INTO Student (stuid, major) VALUES (9, 104);
INSERT INTO Student (stuid, major) VALUES (10, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
(101,)
*/
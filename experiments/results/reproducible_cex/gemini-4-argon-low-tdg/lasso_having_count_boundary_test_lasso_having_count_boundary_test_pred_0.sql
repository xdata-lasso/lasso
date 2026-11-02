-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (stuid, major) VALUES (1, 100);
INSERT INTO Student (stuid, major) VALUES (2, 200);
INSERT INTO Student (stuid, major) VALUES (3, 200);
INSERT INTO Student (stuid, major) VALUES (4, 300);
INSERT INTO Student (stuid, major) VALUES (5, 300);
INSERT INTO Student (stuid, major) VALUES (6, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(100,)
(200,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
(100,)
*/
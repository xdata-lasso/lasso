-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (stuid, major) VALUES (1, 100);
INSERT INTO Student (stuid, major) VALUES (2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
*/
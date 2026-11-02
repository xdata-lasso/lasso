-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "major") VALUES (1001, 1004);
INSERT INTO "student" ("stuid", "major") VALUES (1002, 1004);
INSERT INTO "student" ("stuid", "major") VALUES (1003, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM Student GROUP BY major) WHERE n <= 3;

/*
Gold Result:
(1004,)
*/

-- Prediction Query
SELECT major FROM STUDENT GROUP BY major HAVING COUNT(*) < 3;

/*
Prediction Result:
*/
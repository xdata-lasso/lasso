-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "major") VALUES (1, 100);
INSERT INTO "Student" ("stuid", "major") VALUES (2, 100);
INSERT INTO "Student" ("stuid", "major") VALUES (3, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM Student GROUP BY major) WHERE n <= 3;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT major FROM STUDENT GROUP BY major HAVING COUNT(*) < 3;

/*
Prediction Result:
*/
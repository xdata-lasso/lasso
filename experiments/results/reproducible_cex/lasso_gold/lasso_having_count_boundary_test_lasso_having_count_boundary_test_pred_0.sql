-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "major") VALUES (1013, 1014);
INSERT INTO "student" ("stuid", "major") VALUES (1015, 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(1014,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
*/
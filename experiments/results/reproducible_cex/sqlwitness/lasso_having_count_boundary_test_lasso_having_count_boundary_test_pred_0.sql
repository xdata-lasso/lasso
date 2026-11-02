-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO student (stuid, major) VALUES (0, 1), (1, 1), (2, NULL), (3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(None,)
(1,)
(3,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
(None,)
(3,)
*/
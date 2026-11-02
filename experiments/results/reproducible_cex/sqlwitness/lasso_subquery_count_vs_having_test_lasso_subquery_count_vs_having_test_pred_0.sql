-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO student (stuid, major) VALUES (1, 3), (3, 4), (4, 1), (2, 1), (0, 3), (5, 3), (6, 2), (7, 3), (8, 0), (9, 3), (10, 2), (11, 2), (12, 0), (13, 0), (14, 4), (15, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM Student GROUP BY major) WHERE n <= 3;

/*
Gold Result:
(0,)
(1,)
(2,)
(4,)
*/

-- Prediction Query
SELECT major FROM STUDENT GROUP BY major HAVING COUNT(*) < 3;

/*
Prediction Result:
(1,)
*/
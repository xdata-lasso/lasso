-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (stuid, major) VALUES (1, 100);
INSERT INTO Student (stuid, major) VALUES (2, 200);
INSERT INTO Student (stuid, major) VALUES (3, 200);
INSERT INTO Student (stuid, major) VALUES (4, 300);
INSERT INTO Student (stuid, major) VALUES (5, 300);
INSERT INTO Student (stuid, major) VALUES (6, 300);
INSERT INTO Student (stuid, major) VALUES (7, 400);
INSERT INTO Student (stuid, major) VALUES (8, 400);
INSERT INTO Student (stuid, major) VALUES (9, 400);
INSERT INTO Student (stuid, major) VALUES (10, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM Student GROUP BY major) WHERE n <= 3;

/*
Gold Result:
(100,)
(200,)
(300,)
*/

-- Prediction Query
SELECT major FROM STUDENT GROUP BY major HAVING COUNT(*) < 3;

/*
Prediction Result:
(100,)
(200,)
*/
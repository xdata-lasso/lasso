-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for group counts: 1, 2, 3, 4, and 5.
-- Also tests major values > 3 with count <= 3, and major values <= 3 with count > 3 (catches WHERE major <= 3 vs WHERE n <= 3).
INSERT INTO Student (stuid, major) VALUES (101, 10);
INSERT INTO Student (stuid, major) VALUES (102, 20);
INSERT INTO Student (stuid, major) VALUES (103, 20);
INSERT INTO Student (stuid, major) VALUES (104, 30);
INSERT INTO Student (stuid, major) VALUES (105, 30);
INSERT INTO Student (stuid, major) VALUES (106, 30);
INSERT INTO Student (stuid, major) VALUES (107, 1);
INSERT INTO Student (stuid, major) VALUES (108, 1);
INSERT INTO Student (stuid, major) VALUES (109, 1);
INSERT INTO Student (stuid, major) VALUES (110, 1);
INSERT INTO Student (stuid, major) VALUES (111, 2);
INSERT INTO Student (stuid, major) VALUES (112, 2);
INSERT INTO Student (stuid, major) VALUES (113, 2);
INSERT INTO Student (stuid, major) VALUES (114, 2);
INSERT INTO Student (stuid, major) VALUES (115, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM Student GROUP BY major) WHERE n <= 3;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT major FROM STUDENT GROUP BY major HAVING COUNT(*) < 3;

/*
Prediction Result:
(10,)
(20,)
*/
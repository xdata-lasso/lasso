-- Schema DDL
CREATE TABLE "Student" ("stuid" INTEGER PRIMARY KEY, "major" INTEGER NOT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (stuid, major) VALUES (101, 10);
INSERT INTO Student (stuid, major) VALUES (102, 20);
INSERT INTO Student (stuid, major) VALUES (103, 20);
INSERT INTO Student (stuid, major) VALUES (104, 30);
INSERT INTO Student (stuid, major) VALUES (105, 30);
INSERT INTO Student (stuid, major) VALUES (106, 30);
INSERT INTO Student (stuid, major) VALUES (107, 40);
INSERT INTO Student (stuid, major) VALUES (108, 40);
INSERT INTO Student (stuid, major) VALUES (109, 40);
INSERT INTO Student (stuid, major) VALUES (110, 40);
INSERT INTO Student (stuid, major) VALUES (111, 50);
INSERT INTO Student (stuid, major) VALUES (112, 50);
INSERT INTO Student (stuid, major) VALUES (113, 50);
INSERT INTO Student (stuid, major) VALUES (114, 50);
INSERT INTO Student (stuid, major) VALUES (115, 50);
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
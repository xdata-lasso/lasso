-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('A', NULL);
INSERT INTO courses (student, class) VALUES ('B', NULL);
INSERT INTO courses (student, class) VALUES ('C', NULL);
INSERT INTO courses (student, class) VALUES ('D', NULL);
INSERT INTO courses (student, class) VALUES ('E', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS NUMBER_OF_STUDENTS FROM COURSES GROUP BY CLASS) AS A WHERE NUMBER_OF_STUDENTS >= 5;

/*
Prediction Result:
(None,)
*/
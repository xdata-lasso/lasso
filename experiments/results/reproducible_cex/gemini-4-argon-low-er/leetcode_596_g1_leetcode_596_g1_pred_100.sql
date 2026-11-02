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
WITH AGG AS (SELECT CLASS, COUNT(*) AS A FROM COURSES GROUP BY CLASS) SELECT CLASS FROM AGG WHERE A >= 5;

/*
Prediction Result:
(None,)
*/
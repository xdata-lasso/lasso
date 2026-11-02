-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('1', NULL);
INSERT INTO courses (student, class) VALUES ('2', NULL);
INSERT INTO courses (student, class) VALUES ('3', NULL);
INSERT INTO courses (student, class) VALUES ('4', NULL);
INSERT INTO courses (student, class) VALUES ('5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CLASS, COUNT(STUDENT) AS CNT FROM COURSES GROUP BY 1) SELECT CLASS FROM CTE WHERE CNT >= 5;

/*
Prediction Result:
(None,)
*/
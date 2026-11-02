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
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT CLASS, STUDENT FROM COURSES) AS T GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
*/
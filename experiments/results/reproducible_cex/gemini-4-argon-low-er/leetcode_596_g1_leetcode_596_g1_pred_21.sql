-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('S1', NULL);
INSERT INTO courses (student, class) VALUES ('S2', NULL);
INSERT INTO courses (student, class) VALUES ('S3', NULL);
INSERT INTO courses (student, class) VALUES ('S4', NULL);
INSERT INTO courses (student, class) VALUES ('S5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS INNER_NUMBER_OF_VALUES FROM COURSES GROUP BY CLASS) AS INNER_QUERY WHERE INNER_NUMBER_OF_VALUES >= 5;

/*
Prediction Result:
(None,)
*/
-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO courses (student, class) VALUES ('S1', NULL);
INSERT INTO courses (student, class) VALUES ('S2', NULL);
INSERT INTO courses (student, class) VALUES ('S3', NULL);
INSERT INTO courses (student, class) VALUES ('S4', NULL);
INSERT INTO courses (student, class) VALUES ('S5', NULL);
INSERT INTO courses (student, class) VALUES ('S6', 'Art');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT STUDENT, CLASS FROM COURSES) AS S GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
*/
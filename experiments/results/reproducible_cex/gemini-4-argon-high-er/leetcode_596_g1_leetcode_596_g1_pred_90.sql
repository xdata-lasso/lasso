-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('s1', NULL);
INSERT INTO courses (student, class) VALUES ('s2', NULL);
INSERT INTO courses (student, class) VALUES ('s3', NULL);
INSERT INTO courses (student, class) VALUES ('s4', NULL);
INSERT INTO courses (student, class) VALUES ('s5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT X.CLASS FROM (SELECT COUNT(DISTINCT C.STUDENT) AS NUMSTUDENTS, C.CLASS FROM COURSES AS C GROUP BY CLASS) AS X WHERE X.NUMSTUDENTS >= 5;

/*
Prediction Result:
(None,)
*/
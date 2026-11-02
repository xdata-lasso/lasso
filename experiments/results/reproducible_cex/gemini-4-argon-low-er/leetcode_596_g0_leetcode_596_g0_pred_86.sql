-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('S1', 'Math');
INSERT INTO courses (student, class) VALUES ('S2', 'Math');
INSERT INTO courses (student, class) VALUES ('S3', 'Math');
INSERT INTO courses (student, class) VALUES ('S4', 'Math');
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS STUDENTS FROM COURSES GROUP BY 1 HAVING COUNT(DISTINCT STUDENT) >= 5) AS IO;

/*
Prediction Result:
*/
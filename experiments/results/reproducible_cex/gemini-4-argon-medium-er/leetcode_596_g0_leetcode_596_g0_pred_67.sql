-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('s1', 'Math');
INSERT INTO courses (student, class) VALUES ('s2', 'Math');
INSERT INTO courses (student, class) VALUES ('s3', 'Math');
INSERT INTO courses (student, class) VALUES ('s4', 'Math');
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
WITH A AS (SELECT CLASS, COUNT(DISTINCT (STUDENT)) AS STUD_COUNT FROM COURSES GROUP BY CLASS HAVING STUD_COUNT > 4) SELECT CLASS FROM A;

/*
Prediction Result:
*/
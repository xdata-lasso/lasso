-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('s1', 'c1');
INSERT INTO courses (student, class) VALUES ('s2', 'c1');
INSERT INTO courses (student, class) VALUES ('s3', 'c1');
INSERT INTO courses (student, class) VALUES ('s4', 'c1');
INSERT INTO courses (student, class) VALUES (NULL, 'c1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('c1',)
*/

-- Prediction Query
WITH C AS (SELECT DISTINCT * FROM COURSES) SELECT CLASS FROM C GROUP BY CLASS HAVING COUNT(STUDENT) >= 5;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('s1', 'A');
INSERT INTO courses (student, class) VALUES ('s2', 'A');
INSERT INTO courses (student, class) VALUES ('s3', 'A');
INSERT INTO courses (student, class) VALUES ('s4', 'A');
INSERT INTO courses (student, class) VALUES (NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(DISTINCT STUDENT) >= 5 ORDER BY 1, CLASS NULLS LAST;

/*
Prediction Result:
*/
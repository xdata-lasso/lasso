-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES ('A', 'Math');
INSERT INTO courses (student, class) VALUES ('B', 'Math');
INSERT INTO courses (student, class) VALUES ('C', 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
WITH C AS (SELECT DISTINCT * FROM COURSES) SELECT CLASS FROM C GROUP BY CLASS HAVING COUNT(STUDENT) >= 5;

/*
Prediction Result:
*/
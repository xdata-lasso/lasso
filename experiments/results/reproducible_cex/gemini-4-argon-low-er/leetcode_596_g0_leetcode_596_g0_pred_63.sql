-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
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
SELECT CLASS FROM (SELECT STUDENT, CLASS FROM COURSES GROUP BY 1, 2) AS T GROUP BY 1 HAVING COUNT(*) >= 5;

/*
Prediction Result:
*/
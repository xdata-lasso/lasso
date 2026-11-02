-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES (NULL, 'Math');
INSERT INTO courses (student, class) VALUES ('A', 'Math');
INSERT INTO courses (student, class) VALUES ('B', 'Math');
INSERT INTO courses (student, class) VALUES ('C', 'Math');
INSERT INTO courses (student, class) VALUES ('D', 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
WITH DT AS (SELECT CLASS, COUNT(DISTINCT STUDENT) AS NUM_STUDENTS FROM COURSES GROUP BY 1) SELECT CLASS FROM DT WHERE NUM_STUDENTS >= 5;

/*
Prediction Result:
*/
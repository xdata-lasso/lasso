-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('A', 'Math');
INSERT INTO courses (student, class) VALUES ('B', 'Math');
INSERT INTO courses (student, class) VALUES ('C', 'Math');
INSERT INTO courses (student, class) VALUES ('D', 'Math');
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
SELECT SUB.CLASS FROM (SELECT COUNT(DISTINCT STUDENT) AS COUNTS, CLASS FROM COURSES GROUP BY CLASS) AS SUB WHERE SUB.COUNTS >= 5;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('1', 'Math');
INSERT INTO courses (student, class) VALUES ('2', 'Math');
INSERT INTO courses (student, class) VALUES ('3', 'Math');
INSERT INTO courses (student, class) VALUES ('4', 'Math');
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
SELECT A.CLASS FROM COURSES AS A GROUP BY A.CLASS HAVING COUNT(DISTINCT (A.STUDENT)) >= 5;

/*
Prediction Result:
*/
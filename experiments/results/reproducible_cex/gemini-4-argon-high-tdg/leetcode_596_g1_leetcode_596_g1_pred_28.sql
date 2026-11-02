-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO courses (student, class) VALUES ('s1', NULL);
INSERT INTO courses (student, class) VALUES ('s2', NULL);
INSERT INTO courses (student, class) VALUES ('s3', NULL);
INSERT INTO courses (student, class) VALUES ('s4', NULL);
INSERT INTO courses (student, class) VALUES ('s5', NULL);
INSERT INTO courses (student, class) VALUES ('s6', NULL);
INSERT INTO courses (student, class) VALUES ('s7', 'Math');
INSERT INTO courses (student, class) VALUES ('s8', 'Math');
INSERT INTO courses (student, class) VALUES ('s9', 'Math');
INSERT INTO courses (student, class) VALUES ('s10', 'Math');
INSERT INTO courses (student, class) VALUES ('s11', 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS VALUE FROM COURSES GROUP BY CLASS) AS T_TABLE WHERE VALUE >= 5;

/*
Prediction Result:
(None,)
('Math',)
*/
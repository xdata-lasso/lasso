-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL class handling when NULL group has >= 5 rows (kills COUNT(class) vs COUNT(*) mutants and WHERE class IS NOT NULL mutants).
INSERT INTO courses (student, class) VALUES ('S1', NULL);
INSERT INTO courses (student, class) VALUES ('S2', NULL);
INSERT INTO courses (student, class) VALUES ('S3', NULL);
INSERT INTO courses (student, class) VALUES ('S4', NULL);
INSERT INTO courses (student, class) VALUES ('S5', NULL);
INSERT INTO courses (student, class) VALUES ('S6', 'History');
INSERT INTO courses (student, class) VALUES ('S7', 'History');
INSERT INTO courses (student, class) VALUES ('S8', 'History');
INSERT INTO courses (student, class) VALUES ('S9', 'History');
INSERT INTO courses (student, class) VALUES ('S10', 'History');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('History',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT * FROM COURSES) AS C GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('History',)
*/
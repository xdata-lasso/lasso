-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests NULL handling: 5 NULL classes vs 5 valid classes
-- Catches mutations like COUNT(*) >= 5 or COUNT(student) >= 5 (which would include the NULL group)
INSERT INTO courses (student, class) VALUES ('S1', NULL);
INSERT INTO courses (student, class) VALUES ('S2', NULL);
INSERT INTO courses (student, class) VALUES ('S3', NULL);
INSERT INTO courses (student, class) VALUES ('S4', NULL);
INSERT INTO courses (student, class) VALUES ('S5', NULL);
INSERT INTO courses (student, class) VALUES ('S6', 'Physics');
INSERT INTO courses (student, class) VALUES ('S7', 'Physics');
INSERT INTO courses (student, class) VALUES ('S8', 'Physics');
INSERT INTO courses (student, class) VALUES ('S9', 'Physics');
INSERT INTO courses (student, class) VALUES ('S10', 'Physics');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('Physics',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(1) >= 5;

/*
Prediction Result:
(None,)
('Physics',)
*/
-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition: COUNT(class) = 5 vs COUNT(class) = 4
-- Catches mutations like > 5, >= 4, <= 5, = 4
INSERT INTO courses (student, class) VALUES ('S1', 'Math');
INSERT INTO courses (student, class) VALUES ('S2', 'Math');
INSERT INTO courses (student, class) VALUES ('S3', 'Math');
INSERT INTO courses (student, class) VALUES ('S4', 'Math');
INSERT INTO courses (student, class) VALUES ('S5', 'Math');
INSERT INTO courses (student, class) VALUES ('S6', 'English');
INSERT INTO courses (student, class) VALUES ('S7', 'English');
INSERT INTO courses (student, class) VALUES ('S8', 'English');
INSERT INTO courses (student, class) VALUES ('S9', 'English');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) > 1;

/*
Prediction Result:
('English',)
('Math',)
*/
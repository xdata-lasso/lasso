-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
-- Tests NULL student (allowed by SQLite TEXT PRIMARY KEY) and single-row/small groups (kills COUNT(student) vs COUNT(*) mutants).
INSERT INTO courses (student, class) VALUES (NULL, 'Drama');
INSERT INTO courses (student, class) VALUES ('S1', 'Drama');
INSERT INTO courses (student, class) VALUES ('S2', 'Drama');
INSERT INTO courses (student, class) VALUES ('S3', 'Drama');
INSERT INTO courses (student, class) VALUES ('S4', 'Drama');
INSERT INTO courses (student, class) VALUES ('S5', 'Dance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('Drama',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS A FROM COURSES GROUP BY CLASS) AS TEMP WHERE A >= 5;

/*
Prediction Result:
*/
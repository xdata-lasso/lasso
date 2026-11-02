-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO courses (student, class) VALUES ('A', NULL);
INSERT INTO courses (student, class) VALUES ('B', NULL);
INSERT INTO courses (student, class) VALUES ('C', NULL);
INSERT INTO courses (student, class) VALUES ('D', NULL);
INSERT INTO courses (student, class) VALUES ('E', NULL);
INSERT INTO courses (student, class) VALUES ('F', 'History');
INSERT INTO courses (student, class) VALUES ('G', 'History');
INSERT INTO courses (student, class) VALUES ('H', 'History');
INSERT INTO courses (student, class) VALUES ('I', 'History');
INSERT INTO courses (student, class) VALUES ('J', 'History');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('History',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS NEW WHERE NUM >= 5;

/*
Prediction Result:
(None,)
('History',)
*/
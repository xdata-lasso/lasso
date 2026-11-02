-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO courses (student, class) VALUES ('s1', NULL);
INSERT INTO courses (student, class) VALUES ('s2', NULL);
INSERT INTO courses (student, class) VALUES ('s3', NULL);
INSERT INTO courses (student, class) VALUES ('s4', NULL);
INSERT INTO courses (student, class) VALUES ('s5', NULL);
INSERT INTO courses (student, class) VALUES ('s6', 'CS');
INSERT INTO courses (student, class) VALUES ('s7', 'CS');
INSERT INTO courses (student, class) VALUES ('s8', 'CS');
INSERT INTO courses (student, class) VALUES ('s9', 'CS');
INSERT INTO courses (student, class) VALUES ('s10', 'CS');
INSERT INTO courses (student, class) VALUES ('s11', 'Physics');
INSERT INTO courses (student, class) VALUES ('s12', 'Physics');
INSERT INTO courses (student, class) VALUES ('s13', 'Physics');
INSERT INTO courses (student, class) VALUES ('s14', 'Physics');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('CS',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT STUDENT, CLASS FROM COURSES) AS S GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('CS',)
*/
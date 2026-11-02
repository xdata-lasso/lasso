-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES (NULL, 'A');
INSERT INTO "courses" ("student", "class") VALUES ('s1', 'A');
INSERT INTO "courses" ("student", "class") VALUES ('s2', 'A');
INSERT INTO "courses" ("student", "class") VALUES ('s3', 'A');
INSERT INTO "courses" ("student", "class") VALUES ('s4', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS NEW WHERE NUM >= 5;

/*
Prediction Result:
*/
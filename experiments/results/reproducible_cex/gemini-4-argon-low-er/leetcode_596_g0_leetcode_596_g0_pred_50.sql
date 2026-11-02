-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES (NULL, 'Math');
INSERT INTO "courses" ("student", "class") VALUES ('s1', 'Math');
INSERT INTO "courses" ("student", "class") VALUES ('s2', 'Math');
INSERT INTO "courses" ("student", "class") VALUES ('s3', 'Math');
INSERT INTO "courses" ("student", "class") VALUES ('s4', 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('Math',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS N FROM COURSES GROUP BY CLASS) AS A WHERE N >= 5;

/*
Prediction Result:
*/
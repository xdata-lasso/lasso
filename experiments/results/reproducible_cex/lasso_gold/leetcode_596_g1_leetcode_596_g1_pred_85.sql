-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES ('early', 'decide');
INSERT INTO "courses" ("student", "class") VALUES ('mouth', 'decide');
INSERT INTO "courses" ("student", "class") VALUES ('play', 'decide');
INSERT INTO "courses" ("student", "class") VALUES ('agreement', 'decide');
INSERT INTO "courses" ("student", "class") VALUES ('option', 'decide');
INSERT INTO "courses" ("student", "class") VALUES ('sense', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('rate', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('science', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('offer', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('kind', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('decide',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS STUDENTS FROM COURSES GROUP BY 1 HAVING COUNT(DISTINCT STUDENT) >= 5) AS IO;

/*
Prediction Result:
(None,)
('decide',)
*/
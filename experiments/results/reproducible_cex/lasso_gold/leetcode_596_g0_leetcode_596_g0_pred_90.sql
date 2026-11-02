-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES ('play', 'rate');
INSERT INTO "courses" ("student", "class") VALUES ('agreement', 'rate');
INSERT INTO "courses" ("student", "class") VALUES ('option', 'rate');
INSERT INTO "courses" ("student", "class") VALUES ('decide', 'rate');
INSERT INTO "courses" ("student", "class") VALUES ('sense', 'rate');
INSERT INTO "courses" ("student", "class") VALUES ('science', 'fall');
INSERT INTO "courses" ("student", "class") VALUES ('offer', 'perform');
INSERT INTO "courses" ("student", "class") VALUES ('kind', 'perform');
INSERT INTO "courses" ("student", "class") VALUES ('discussion', 'perform');
INSERT INTO "courses" ("student", "class") VALUES ('list', 'perform');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('rate',)
*/

-- Prediction Query
SELECT COURSES.CLASS FROM COURSES GROUP BY COURSES.CLASS HAVING COUNT(DISTINCT STUDENT) >= 4;

/*
Prediction Result:
('perform',)
('rate',)
*/
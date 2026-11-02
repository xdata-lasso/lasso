-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES ('dog', 'sit');
INSERT INTO "courses" ("student", "class") VALUES ('chair', 'sit');
INSERT INTO "courses" ("student", "class") VALUES ('since', 'sit');
INSERT INTO "courses" ("student", "class") VALUES ('blue', 'sit');
INSERT INTO "courses" ("student", "class") VALUES ('require', 'sit');
INSERT INTO "courses" ("student", "class") VALUES ('wait', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('offer', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('begin', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('performance', NULL);
INSERT INTO "courses" ("student", "class") VALUES ('knowledge', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('sit',)
*/

-- Prediction Query
SELECT TBL1.CLASS FROM (SELECT CLASS, COUNT(CLASS) AS MYCOUNT FROM COURSES GROUP BY CLASS) AS TBL1 WHERE TBL1.MYCOUNT >= 5;

/*
Prediction Result:
('sit',)
*/
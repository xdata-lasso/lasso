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
SELECT COURSES.CLASS AS CLASS FROM (SELECT DISTINCT * FROM COURSES) AS COURSES GROUP BY COURSES.CLASS HAVING COUNT(COURSES.CLASS) >= 5;

/*
Prediction Result:
('sit',)
*/
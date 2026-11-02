-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("student", "class") VALUES ('dog', 'offer');
INSERT INTO "courses" ("student", "class") VALUES ('wait', 'offer');
INSERT INTO "courses" ("student", "class") VALUES ('begin', 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) > 1;

/*
Prediction Result:
('offer',)
*/
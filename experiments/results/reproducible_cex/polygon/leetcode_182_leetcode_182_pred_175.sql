-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (7, '8');
INSERT INTO "Person" ("id", "email") VALUES (6, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('8',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, COUNT(*) OVER (PARTITION BY EMAIL) AS NNUM FROM PERSON) AS A WHERE NNUM > 1;

/*
Prediction Result:
('8',)
*/
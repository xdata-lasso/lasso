-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (7, NULL);
INSERT INTO "Person" ("id", "email") VALUES (6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT DISTINCT EMAIL, COUNT(*) AS CNT FROM PERSON GROUP BY EMAIL) AS E WHERE CNT > 1;

/*
Prediction Result:
(None,)
*/
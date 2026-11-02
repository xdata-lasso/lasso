-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (7, '11');
INSERT INTO "Person" ("id", "email") VALUES (6, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, COUNT(EMAIL) OVER (PARTITION BY EMAIL) AS EMAIL_COUNT FROM PERSON) AS EMAIL_COUNTS WHERE EMAIL_COUNTS.EMAIL_COUNT > 1;

/*
Prediction Result:
*/
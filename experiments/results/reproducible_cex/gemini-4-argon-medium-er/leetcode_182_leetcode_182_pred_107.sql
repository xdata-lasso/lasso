-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("Id", "Email") VALUES (1, NULL);
INSERT INTO "Person" ("Id", "Email") VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT TMP.EMAIL AS EMAIL FROM (SELECT COUNT(*) AS DUPLICATES, EMAIL FROM PERSON GROUP BY EMAIL) AS TMP WHERE TMP.DUPLICATES > 1;

/*
Prediction Result:
(None,)
*/
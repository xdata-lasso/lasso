-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (6, NULL);
INSERT INTO "Person" ("id", "email") VALUES (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.EMAIL FROM (SELECT EMAIL, COUNT(ID) AS NEMAIL FROM PERSON GROUP BY EMAIL HAVING NEMAIL >= 2) AS A;

/*
Prediction Result:
(None,)
*/
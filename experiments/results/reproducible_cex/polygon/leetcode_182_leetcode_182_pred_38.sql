-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (5, NULL);
INSERT INTO "Person" ("id", "email") VALUES (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.EMAIL FROM PERSON AS A GROUP BY EMAIL HAVING COUNT(ID) > 1;

/*
Prediction Result:
(None,)
*/
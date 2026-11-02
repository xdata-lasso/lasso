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
SELECT P.EMAIL FROM (SELECT PERSON.EMAIL, COUNT(*) AS DUP FROM PERSON GROUP BY EMAIL) AS P WHERE P.DUP > 1;

/*
Prediction Result:
(None,)
*/
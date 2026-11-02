-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (323, NULL);
INSERT INTO "Person" ("id", "email") VALUES (324, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL FROM PERSON GROUP BY EMAIL HAVING MIN(ID) <> MAX(ID);

/*
Prediction Result:
(None,)
*/
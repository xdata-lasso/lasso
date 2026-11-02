-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default2'), (1, NULL), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT EMAIL, COUNT(1) AS EMAIL_COUNT FROM PERSON GROUP BY EMAIL HAVING EMAIL_COUNT > 1) AS T;

/*
Prediction Result:
(None,)
*/
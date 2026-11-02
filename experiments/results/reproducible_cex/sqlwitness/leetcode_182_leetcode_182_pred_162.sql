-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (3, 'default2'), (1, NULL), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT EMAIL, COUNT(*) FROM PERSON GROUP BY EMAIL HAVING COUNT(*) >= 2) AS Q1;

/*
Prediction Result:
(None,)
*/
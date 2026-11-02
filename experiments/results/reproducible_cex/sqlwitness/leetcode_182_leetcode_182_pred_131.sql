-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, NULL), (0, 'default2'), (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.EMAIL FROM (SELECT EMAIL, COUNT(*) AS C FROM PERSON GROUP BY EMAIL) AS T WHERE T.C > 1;

/*
Prediction Result:
(None,)
*/
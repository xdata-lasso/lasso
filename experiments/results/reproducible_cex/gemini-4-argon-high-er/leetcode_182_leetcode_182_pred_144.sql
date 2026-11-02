-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Person (Id, Email) VALUES (1, NULL);
INSERT INTO Person (Id, Email) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT COUNT(*) AS EMAIL_NUM, EMAIL AS EMAIL FROM PERSON GROUP BY EMAIL) SELECT EMAIL FROM CTE WHERE EMAIL_NUM > 1;

/*
Prediction Result:
(None,)
*/
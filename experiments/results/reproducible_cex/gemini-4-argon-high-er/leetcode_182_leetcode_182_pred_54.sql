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
WITH T AS (SELECT EMAIL, DENSE_RANK() OVER (ORDER BY EMAIL) AS EMAILNUM FROM PERSON) SELECT EMAIL FROM T GROUP BY EMAILNUM HAVING COUNT(EMAILNUM) > 1;

/*
Prediction Result:
(None,)
*/
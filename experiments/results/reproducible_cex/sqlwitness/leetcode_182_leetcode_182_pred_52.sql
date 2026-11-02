-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (2, 'default1'), (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS ROW_NUM FROM PERSON) SELECT DISTINCT EMAIL FROM CTE WHERE ROW_NUM > 1;

/*
Prediction Result:
(None,)
*/
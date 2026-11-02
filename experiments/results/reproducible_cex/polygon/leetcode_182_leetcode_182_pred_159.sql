-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (6, 'row_number6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS RNK FROM PERSON) SELECT DISTINCT EMAIL FROM CTE WHERE RNK > 1;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (5, 'dense_rank7');
INSERT INTO "Person" ("id", "email") VALUES (4, 'dense_rank6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT EMAIL, DENSE_RANK() OVER (PARTITION BY NULL ORDER BY EMAIL ASC) AS RANK FROM PERSON) AS TEMP GROUP BY TEMP.RANK HAVING COUNT(EMAIL) > 1;

/*
Prediction Result:
*/
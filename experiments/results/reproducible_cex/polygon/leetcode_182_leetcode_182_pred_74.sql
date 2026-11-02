-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (6, 'row_number7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT ID, EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY EMAIL) AS BLAH FROM PERSON) AS SUBTAB WHERE SUBTAB.BLAH > 1;

/*
Prediction Result:
*/
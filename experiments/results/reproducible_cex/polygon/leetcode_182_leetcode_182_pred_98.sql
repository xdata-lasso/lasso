-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (6, 'row_number7');
INSERT INTO "Person" ("id", "email") VALUES (5, 'row_number7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('row_number7',)
*/

-- Prediction Query
WITH X AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS ROW_NUM FROM PERSON) SELECT EMAIL FROM X WHERE ROW_NUM = 2;

/*
Prediction Result:
('row_number7',)
*/
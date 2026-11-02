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
SELECT T.EMAIL AS EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS R FROM PERSON) AS T WHERE T.R = 2;

/*
Prediction Result:
('row_number7',)
*/
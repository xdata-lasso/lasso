-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("id", "email") VALUES (7, 'row_number8');
INSERT INTO "Person" ("id", "email") VALUES (6, 'row_number8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('row_number8',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS RNK FROM PERSON) AS A WHERE A.RNK > 1;

/*
Prediction Result:
('row_number8',)
*/
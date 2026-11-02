-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Person (Id, Email) VALUES (1, NULL);
INSERT INTO Person (Id, Email) VALUES (2, NULL);
INSERT INTO Person (Id, Email) VALUES (3, 'frank@example.com');
INSERT INTO Person (Id, Email) VALUES (4, 'frank@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('frank@example.com',)
*/

-- Prediction Query
WITH DUPTABLE AS (SELECT ID, EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS ROW_NUM FROM PERSON) SELECT DISTINCT EMAIL FROM DUPTABLE WHERE ROW_NUM <> 1;

/*
Prediction Result:
(None,)
('frank@example.com',)
*/
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
WITH CTE1 AS (SELECT COUNT(EMAIL) AS COUNT_1, EMAIL FROM PERSON GROUP BY EMAIL) SELECT EMAIL FROM CTE1 WHERE COUNT_1 <> 1;

/*
Prediction Result:
(None,)
('frank@example.com',)
*/
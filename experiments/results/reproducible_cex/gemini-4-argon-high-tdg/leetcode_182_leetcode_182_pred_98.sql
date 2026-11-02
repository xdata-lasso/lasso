-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Person (Id, Email) VALUES (1, NULL);
INSERT INTO Person (Id, Email) VALUES (2, NULL);
INSERT INTO Person (Id, Email) VALUES (3, 'dup@example.com');
INSERT INTO Person (Id, Email) VALUES (4, 'dup@example.com');
INSERT INTO Person (Id, Email) VALUES (5, 'unique@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('dup@example.com',)
*/

-- Prediction Query
WITH X AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS ROW_NUM FROM PERSON) SELECT EMAIL FROM X WHERE ROW_NUM = 2;

/*
Prediction Result:
(None,)
('dup@example.com',)
*/
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
WITH A AS (SELECT EMAIL, COUNT(*) AS NUM FROM PERSON GROUP BY EMAIL) SELECT EMAIL AS EMAIL FROM A WHERE NUM > 1;

/*
Prediction Result:
(None,)
('dup@example.com',)
*/
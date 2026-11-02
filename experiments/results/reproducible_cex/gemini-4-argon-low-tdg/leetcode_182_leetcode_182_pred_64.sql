-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Person (Id, Email) VALUES (1, NULL);
INSERT INTO Person (Id, Email) VALUES (2, NULL);
INSERT INTO Person (Id, Email) VALUES (3, 'valid@test.com');
INSERT INTO Person (Id, Email) VALUES (4, 'valid@test.com');
INSERT INTO Person (Id, Email) VALUES (5, 'single@test.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('valid@test.com',)
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT EMAIL, COUNT(*) AS CT FROM PERSON GROUP BY EMAIL HAVING CT > 1) AS A;

/*
Prediction Result:
(None,)
('valid@test.com',)
*/
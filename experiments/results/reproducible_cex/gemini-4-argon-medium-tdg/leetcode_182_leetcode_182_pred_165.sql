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
SELECT A.EMAIL FROM (SELECT P.EMAIL, COUNT(ID) AS T_ID FROM PERSON AS P GROUP BY P.EMAIL HAVING T_ID > 1) AS A;

/*
Prediction Result:
(None,)
('frank@example.com',)
*/
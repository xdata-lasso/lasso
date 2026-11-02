-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT TMP.EMAIL AS EMAIL FROM (SELECT COUNT(*) AS DUPLICATES, EMAIL FROM PERSON GROUP BY EMAIL) AS TMP WHERE TMP.DUPLICATES > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (3, NULL), (0, 'default2'), (1, NULL), (2, 'default1'), (4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS DUPLICATES FROM PERSON) AS T1 WHERE DUPLICATES = 2;

/*
Prediction Result:
(None,)
('default1',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (2, 'default1'), (1, NULL), (3, 'default1'), (4, 'default1'), (5, 'default2'), (6, NULL), (7, NULL), (8, 'default2'), (9, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T.EMAIL AS EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS R FROM PERSON) AS T WHERE T.R = 2;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
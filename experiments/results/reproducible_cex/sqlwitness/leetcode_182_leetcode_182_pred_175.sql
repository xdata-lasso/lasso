-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (1, 'default1'), (0, NULL), (3, 'default1'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, COUNT(*) OVER (PARTITION BY EMAIL) AS NNUM FROM PERSON) AS A WHERE NNUM > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
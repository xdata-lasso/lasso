-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default1'), (2, NULL), (1, NULL), (3, NULL), (4, 'default1'), (5, NULL), (6, 'default2'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT (EMAIL) FROM (SELECT EMAIL, COUNT(ID) AS CNT FROM PERSON GROUP BY EMAIL) AS TB1 WHERE CNT > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
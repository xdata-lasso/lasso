-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, NULL), (0, 'default2'), (1, NULL), (3, 'default2'), (4, NULL), (5, 'default1'), (6, 'default1');
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
WITH CTE AS (SELECT COUNT(*) AS EMAIL_NUM, EMAIL AS EMAIL FROM PERSON GROUP BY EMAIL) SELECT EMAIL FROM CTE WHERE EMAIL_NUM > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
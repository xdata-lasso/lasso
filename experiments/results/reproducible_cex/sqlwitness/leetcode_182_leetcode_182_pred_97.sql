-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, 'default2'), (2, NULL), (0, NULL), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2');
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
WITH T1 AS (SELECT EMAIL, COUNT(*) FROM PERSON GROUP BY EMAIL HAVING COUNT(*) > 1) SELECT EMAIL FROM T1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
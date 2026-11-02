-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (1, NULL), (0, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, NULL), (9, NULL);
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
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS RNK FROM PERSON) AS A WHERE A.RNK > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
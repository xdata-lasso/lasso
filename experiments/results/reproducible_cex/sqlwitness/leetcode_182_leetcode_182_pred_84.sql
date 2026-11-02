-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (0, NULL), (1, 'default1'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default1');
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
SELECT EMAIL FROM (SELECT EMAIL, COUNT(*) AS CC FROM PERSON GROUP BY EMAIL) AS DUP WHERE CC > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
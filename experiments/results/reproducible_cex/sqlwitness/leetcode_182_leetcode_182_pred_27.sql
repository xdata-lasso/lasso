-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, 'default1'), (0, NULL), (2, NULL), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'default1');
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
SELECT EMAIL FROM PERSON GROUP BY EMAIL HAVING COUNT(ID) > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
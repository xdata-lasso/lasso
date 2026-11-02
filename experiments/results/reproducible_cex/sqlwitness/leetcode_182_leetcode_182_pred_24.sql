-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (2, 'default2'), (1, NULL), (3, 'default1'), (4, NULL), (5, 'default1'), (6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT EMAIL FROM PERSON GROUP BY 1 HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
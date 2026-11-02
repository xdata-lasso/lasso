-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default2'), (1, 'default1'), (2, 'default2'), (3, NULL), (4, NULL), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, NULL), (9, NULL), (10, NULL), (11, NULL);
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
SELECT EMAIL FROM PERSON WHERE ID IN (SELECT MIN(ID) FROM PERSON GROUP BY EMAIL HAVING COUNT(ID) > 1);

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/
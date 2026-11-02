-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, 'default1'), (2, 'default2'), (0, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, NULL), (10, 'default1'), (11, NULL);
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
SELECT EMAIL FROM (SELECT EMAIL AS EMAIL, COUNT(ID) AS NUM FROM PERSON GROUP BY EMAIL) AS HIMAN WHERE NUM > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default2'), (1, NULL), (2, NULL), (3, NULL), (4, 'default1'), (5, 'default2'), (6, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT EMAIL, COUNT(ID) AS COUNT FROM PERSON GROUP BY EMAIL) AS TEMP WHERE TEMP.COUNT > 1;

/*
Prediction Result:
(None,)
('default2',)
*/
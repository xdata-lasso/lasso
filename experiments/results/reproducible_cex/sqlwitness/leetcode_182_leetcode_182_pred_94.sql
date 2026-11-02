-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, NULL), (0, 'default1'), (1, NULL), (3, 'default2'), (4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT TAB.EMAIL FROM (SELECT EMAIL, COUNT(ID) AS NUM FROM PERSON GROUP BY EMAIL HAVING COUNT(ID) > 1) AS TAB;

/*
Prediction Result:
(None,)
('default1',)
*/
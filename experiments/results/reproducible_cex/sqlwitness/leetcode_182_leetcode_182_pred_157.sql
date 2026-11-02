-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, 'default1'), (2, 'default1'), (3, 'default2'), (4, NULL), (5, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT EMAIL, COUNT(ID) AS CNT FROM PERSON GROUP BY EMAIL) AS T WHERE T.CNT > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
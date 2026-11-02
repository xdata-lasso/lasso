-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (2, NULL), (1, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default2');
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
SELECT A.EMAIL AS EMAIL FROM (SELECT EMAIL, COUNT(ID) AS COUNTT FROM PERSON GROUP BY EMAIL) AS A WHERE A.COUNTT > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
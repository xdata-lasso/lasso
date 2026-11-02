-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, NULL), (2, 'default1'), (0, 'default2'), (3, NULL), (4, 'default2'), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT EMAIL, COUNT(ID) AS EMCOUNT FROM PERSON GROUP BY EMAIL) AS T WHERE T.EMCOUNT <> 1;

/*
Prediction Result:
(None,)
('default2',)
*/
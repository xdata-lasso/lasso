-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, NULL), (2, 'default2'), (0, 'default2'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default1'), (7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT P.EMAIL FROM (SELECT PERSON.EMAIL, COUNT(*) AS DUP FROM PERSON GROUP BY EMAIL) AS P WHERE P.DUP > 1;

/*
Prediction Result:
(None,)
('default2',)
*/
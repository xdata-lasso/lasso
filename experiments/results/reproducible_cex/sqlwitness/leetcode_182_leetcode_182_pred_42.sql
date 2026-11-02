-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default1'), (1, NULL), (2, 'default1'), (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT P.EMAIL FROM PERSON AS P GROUP BY P.EMAIL HAVING COUNT(1) > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, NULL), (0, 'default2'), (1, 'default2'), (3, 'default1'), (4, NULL), (5, 'default2'), (6, NULL), (7, 'default1'), (8, 'default1'), (9, 'default1');
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
SELECT T.EMAIL FROM (SELECT ID, EMAIL, COUNT(DISTINCT ID) AS NUM FROM PERSON GROUP BY EMAIL HAVING NUM > 1) AS T;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
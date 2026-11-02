-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, NULL), (8, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT A.EMAIL FROM PERSON AS A INNER JOIN (SELECT * FROM PERSON GROUP BY EMAIL HAVING COUNT(*) > 1) AS B ON A.ID = B.ID;

/*
Prediction Result:
(None,)
('default1',)
*/
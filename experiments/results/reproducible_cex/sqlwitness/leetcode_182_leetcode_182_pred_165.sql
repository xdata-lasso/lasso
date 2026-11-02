-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default2'), (1, NULL), (0, 'default1'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, NULL);
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
SELECT A.EMAIL FROM (SELECT P.EMAIL, COUNT(ID) AS T_ID FROM PERSON AS P GROUP BY P.EMAIL HAVING T_ID > 1) AS A;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
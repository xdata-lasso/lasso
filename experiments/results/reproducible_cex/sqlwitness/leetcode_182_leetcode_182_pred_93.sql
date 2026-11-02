-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, 'default2'), (2, NULL), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1'), (7, NULL), (8, 'default2'), (9, NULL), (10, NULL), (11, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T.EMAIL FROM (SELECT EMAIL, COUNT(*) AS CNT FROM PERSON GROUP BY EMAIL HAVING CNT > 1) AS T;

/*
Prediction Result:
(None,)
('default2',)
*/
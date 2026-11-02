-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default2'), (8, 'default1'), (9, 'default1'), (10, NULL), (11, 'default2');
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
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, COUNT(*) AS NUM FROM PERSON GROUP BY EMAIL HAVING NUM > 1) AS X;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
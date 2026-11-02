-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, 'default2'), (2, NULL), (0, NULL), (3, 'default2'), (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT EMAIL FROM PERSON GROUP BY EMAIL HAVING COUNT(DISTINCT ID) > 1;

/*
Prediction Result:
(None,)
('default2',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default2'), (2, 'default1'), (1, 'default2'), (3, NULL), (4, 'default1'), (5, NULL);
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
WITH COUNTS AS (SELECT EMAIL, COUNT(ID) AS C FROM PERSON GROUP BY EMAIL) SELECT EMAIL FROM COUNTS WHERE C > 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
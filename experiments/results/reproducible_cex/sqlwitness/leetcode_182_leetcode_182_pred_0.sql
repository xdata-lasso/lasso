-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, 'default1'), (1, 'default1'), (2, NULL), (3, NULL), (4, 'default1'), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY EMAIL) AS ROWNUM FROM PERSON) AS A WHERE ROWNUM > 1;

/*
Prediction Result:
(None,)
('default1',)
*/
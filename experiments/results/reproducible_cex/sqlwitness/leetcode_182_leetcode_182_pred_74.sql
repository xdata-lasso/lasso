-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (1, NULL), (0, NULL), (3, NULL), (4, 'default2'), (5, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT ID, EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY EMAIL) AS BLAH FROM PERSON) AS SUBTAB WHERE SUBTAB.BLAH > 1;

/*
Prediction Result:
(None,)
('default2',)
*/
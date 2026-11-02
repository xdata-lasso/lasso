-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default1'), (0, 'default2'), (1, NULL), (3, 'default2'), (4, NULL), (5, 'default1'), (6, 'default2'), (7, NULL), (8, 'default1'), (9, NULL), (10, NULL);
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
WITH DUPTABLE AS (SELECT ID, EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS ROW_NUM FROM PERSON) SELECT DISTINCT EMAIL FROM DUPTABLE WHERE ROW_NUM <> 1;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/
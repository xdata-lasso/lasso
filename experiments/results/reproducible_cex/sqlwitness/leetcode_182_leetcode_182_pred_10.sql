-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT (EMAIL) FROM (SELECT EMAIL, COUNT(*) OVER (PARTITION BY EMAIL) AS CNT FROM PERSON) AS A WHERE A.CNT > 1;

/*
Prediction Result:
(None,)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (2, 'default2'), (0, NULL), (1, 'default1'), (3, NULL), (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT EMAIL, COUNT(*) AS CNT FROM PERSON GROUP BY 1) AS A WHERE CNT > 1;

/*
Prediction Result:
(None,)
*/
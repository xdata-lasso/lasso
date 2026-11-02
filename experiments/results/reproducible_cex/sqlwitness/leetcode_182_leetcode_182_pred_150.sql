-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO person (id, email) VALUES (1, 'default1'), (0, NULL), (2, 'default2'), (3, NULL), (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT EMAIL, COUNT(*) AS NUM FROM PERSON GROUP BY EMAIL) SELECT EMAIL AS EMAIL FROM A WHERE NUM > 1;

/*
Prediction Result:
(None,)
*/
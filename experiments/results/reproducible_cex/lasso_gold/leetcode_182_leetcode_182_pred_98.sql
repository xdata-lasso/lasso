-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "person" ("id", "email") VALUES (1010, 'jesseguzman@example.net');
INSERT INTO "person" ("id", "email") VALUES (1011, 'jesseguzman@example.net');
INSERT INTO "person" ("id", "email") VALUES (1012, NULL);
INSERT INTO "person" ("id", "email") VALUES (1013, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('jesseguzman@example.net',)
*/

-- Prediction Query
WITH X AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS ROW_NUM FROM PERSON) SELECT EMAIL FROM X WHERE ROW_NUM = 2;

/*
Prediction Result:
(None,)
('jesseguzman@example.net',)
*/
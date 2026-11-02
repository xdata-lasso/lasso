-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_109e55');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_109e55',)
*/

-- Prediction Query
SELECT EMAIL AS EMAIL FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS DUPLICATES FROM PERSON) AS T1 WHERE DUPLICATES = 2;

/*
Prediction Result:
(None,)
('per_109e55',)
*/
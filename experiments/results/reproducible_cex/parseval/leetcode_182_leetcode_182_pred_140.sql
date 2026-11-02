-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_a79957');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_a79957',)
*/

-- Prediction Query
SELECT T.EMAIL AS EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS R FROM PERSON) AS T WHERE T.R = 2;

/*
Prediction Result:
(None,)
('per_a79957',)
*/
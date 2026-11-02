-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_2e4d95');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_2e4d95',)
*/

-- Prediction Query
WITH X AS (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS ROW_NUM FROM PERSON) SELECT EMAIL FROM X WHERE ROW_NUM = 2;

/*
Prediction Result:
(None,)
('per_2e4d95',)
*/
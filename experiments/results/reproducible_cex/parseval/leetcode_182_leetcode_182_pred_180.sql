-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_170460');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_170460',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS RNK FROM PERSON) AS A WHERE A.RNK > 1;

/*
Prediction Result:
(None,)
('per_170460',)
*/
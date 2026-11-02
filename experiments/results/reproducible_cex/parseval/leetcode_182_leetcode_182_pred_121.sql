-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_8c53f3');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_8c53f3',)
*/

-- Prediction Query
SELECT DISTINCT EMAIL FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS RN FROM PERSON) AS P WHERE P.RN > 1;

/*
Prediction Result:
(None,)
('per_8c53f3',)
*/
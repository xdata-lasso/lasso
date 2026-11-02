-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_f93a4c');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_f93a4c',)
*/

-- Prediction Query
WITH T1 AS (SELECT EMAIL, COUNT(*) FROM PERSON GROUP BY EMAIL HAVING COUNT(*) > 1) SELECT EMAIL FROM T1;

/*
Prediction Result:
(None,)
('per_f93a4c',)
*/
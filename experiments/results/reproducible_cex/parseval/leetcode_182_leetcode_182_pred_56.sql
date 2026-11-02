-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_760071');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_760071',)
*/

-- Prediction Query
SELECT EMAIL FROM (SELECT EMAIL, COUNT(*) AS CNT FROM PERSON GROUP BY 1) AS A WHERE CNT > 1;

/*
Prediction Result:
(None,)
('per_760071',)
*/
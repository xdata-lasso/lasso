-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_87fc35');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_87fc35',)
*/

-- Prediction Query
SELECT T.EMAIL FROM (SELECT ID, EMAIL, COUNT(DISTINCT ID) AS NUM FROM PERSON GROUP BY EMAIL HAVING NUM > 1) AS T;

/*
Prediction Result:
(None,)
('per_87fc35',)
*/
-- Schema DDL
CREATE TABLE "Person" ("Id" INTEGER PRIMARY KEY, "Email" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("id", "email") VALUES (-2147483648, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (-2147483647, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (-2147483646, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (2, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (3, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (-2147483645, 'per_1cfa2f');

INSERT INTO "person" ("id", "email") VALUES (-2147483642, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483641, NULL);

INSERT INTO "person" ("id", "email") VALUES (-2147483640, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email AS Email FROM Person GROUP BY email HAVING COUNT(email) > 1;

/*
Gold Result:
('per_1cfa2f',)
*/

-- Prediction Query
SELECT A.EMAIL FROM (SELECT P.EMAIL, COUNT(ID) AS T_ID FROM PERSON AS P GROUP BY P.EMAIL HAVING T_ID > 1) AS A;

/*
Prediction Result:
(None,)
('per_1cfa2f',)
*/
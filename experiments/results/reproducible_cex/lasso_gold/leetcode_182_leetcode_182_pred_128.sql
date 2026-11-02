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
SELECT ONE.EMAIL FROM (SELECT PERSON.EMAIL, COUNT(*) FROM PERSON GROUP BY 1 HAVING COUNT(*) > 1) AS ONE;

/*
Prediction Result:
(None,)
('jesseguzman@example.net',)
*/
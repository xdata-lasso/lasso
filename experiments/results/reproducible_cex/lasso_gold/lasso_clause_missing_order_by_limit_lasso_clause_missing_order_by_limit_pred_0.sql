-- Schema DDL
CREATE TABLE "USERS" ("ID" INTEGER PRIMARY KEY, "SCORE" INTEGER, "NAME" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "score", "name") VALUES (1001, 1005, 'Allison Hill');
INSERT INTO "users" ("id", "score", "name") VALUES (1002, 1010.0, 'Noah Rhodes');
INSERT INTO "users" ("id", "score", "name") VALUES (1003, 1015.0, 'Angie Henderson');
INSERT INTO "users" ("id", "score", "name") VALUES (1004, 1020.0, 'Daniel Wagner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM USERS ORDER BY SCORE DESC, USERS.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Daniel Wagner',)
*/

-- Prediction Query
SELECT NAME FROM USERS LIMIT 1;

/*
Prediction Result:
('Allison Hill',)
*/
-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "r" ("a", "b", "c") VALUES (5, 10, -145);
INSERT INTO "r" ("a", "b", "c") VALUES (5, 10, -635);
INSERT INTO "r" ("a", "b", "c") VALUES (-900, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
(10,)
(10,)
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(10,)
(10,)
(10,)
*/
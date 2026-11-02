-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO r (a, b, c) VALUES (5, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(1,)
*/
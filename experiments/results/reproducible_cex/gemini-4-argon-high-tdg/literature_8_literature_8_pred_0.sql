-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO r (a, b, c) VALUES (5, 10, 0);
INSERT INTO r (a, b, c) VALUES (5, 20, 1);
INSERT INTO r (a, b, c) VALUES (5, 30, -1);
INSERT INTO r (a, b, c) VALUES (4, 40, 0);
INSERT INTO r (a, b, c) VALUES (6, 50, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(10,)
(20,)
(30,)
(40,)
(50,)
*/
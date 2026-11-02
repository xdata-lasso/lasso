-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO r (a, b, c) VALUES (5, 100, 0);
INSERT INTO r (a, b, c) VALUES (5, 101, 1);
INSERT INTO r (a, b, c) VALUES (5, 102, 2);
INSERT INTO r (a, b, c) VALUES (4, 103, 0);
INSERT INTO r (a, b, c) VALUES (6, 104, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(100,)
(101,)
(102,)
(103,)
(104,)
*/
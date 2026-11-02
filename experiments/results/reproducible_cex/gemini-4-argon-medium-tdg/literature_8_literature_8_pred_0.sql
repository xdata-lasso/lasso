-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO r (a, b, c) VALUES (5, 100, 0);
INSERT INTO r (a, b, c) VALUES (5, 101, -5);
INSERT INTO r (a, b, c) VALUES (5, 102, 1);
INSERT INTO r (a, b, c) VALUES (5, 103, 2);
INSERT INTO r (a, b, c) VALUES (4, 104, 0);
INSERT INTO r (a, b, c) VALUES (6, 105, 0);
INSERT INTO r (a, b, c) VALUES (4, 106, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
(100,)
(101,)
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
(105,)
(106,)
*/
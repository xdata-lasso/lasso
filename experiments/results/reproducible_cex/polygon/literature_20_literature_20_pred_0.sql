-- Schema DDL
CREATE TABLE "r" ("a1" INTEGER, "a2" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "r" ("a1", "a2") VALUES (14, 15);
INSERT INTO "r" ("a1", "a2") VALUES (14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A1 AS A1, Y.A2 AS A2 FROM R AS X CROSS JOIN R AS Y WHERE X.A1 = Y.A1 AND X.A2 = Y.A2;

/*
Gold Result:
(14, 15)
*/

-- Prediction Query
SELECT DISTINCT X.A1 AS A1, X.A2 AS A2 FROM R AS X;

/*
Prediction Result:
(14, 15)
(14, None)
*/
-- Schema DDL
CREATE TABLE "r" ("a1" INTEGER, "a2" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests NULL semantics in equality conditions (X.A1 = Y.A1 AND X.A2 = Y.A2).
-- Kills mutants using IS NOT DISTINCT FROM, IS NULL, or omitting the WHERE clause entirely.
INSERT INTO r (a1, a2) VALUES (1, 2);
INSERT INTO r (a1, a2) VALUES (1, NULL);
INSERT INTO r (a1, a2) VALUES (NULL, 2);
INSERT INTO r (a1, a2) VALUES (NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A1 AS A1, Y.A2 AS A2 FROM R AS X CROSS JOIN R AS Y WHERE X.A1 = Y.A1 AND X.A2 = Y.A2;

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
SELECT DISTINCT X.A1 AS A1, X.A2 AS A2 FROM R AS X;

/*
Prediction Result:
(1, 2)
(1, None)
(None, 2)
(None, None)
*/
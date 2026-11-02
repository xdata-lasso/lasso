-- Schema DDL
CREATE TABLE "r" ("a" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO r (a) VALUES (NULL);
INSERT INTO r (a) VALUES (1);
INSERT INTO r (a) VALUES (1);
INSERT INTO r (a) VALUES (2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A AS A FROM R AS X CROSS JOIN R AS Y WHERE X.A = Y.A;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT X.A AS A FROM R AS X;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/
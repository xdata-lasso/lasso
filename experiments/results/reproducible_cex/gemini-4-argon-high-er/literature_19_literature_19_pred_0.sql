-- Schema DDL
CREATE TABLE "r" ("a" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO r (a) VALUES (NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A AS A FROM R AS X CROSS JOIN R AS Y WHERE X.A = Y.A;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT X.A AS A FROM R AS X;

/*
Prediction Result:
(None,)
*/
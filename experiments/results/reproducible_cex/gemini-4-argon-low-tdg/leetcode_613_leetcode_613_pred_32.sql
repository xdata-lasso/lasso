-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO point (x) VALUES (-5);
INSERT INTO point (x) VALUES (5);
INSERT INTO point (x) VALUES (12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(7,)
*/

-- Prediction Query
WITH T1 AS (SELECT X, LEAD(X) OVER () AS NEXT FROM POINT), T2 AS (SELECT X, ABS(ABS(X) - ABS(NEXT)) AS DIFF FROM T1), T3 AS (SELECT MIN(DIFF) AS SHORTEST FROM T2) SELECT * FROM T3;

/*
Prediction Result:
(0,)
*/
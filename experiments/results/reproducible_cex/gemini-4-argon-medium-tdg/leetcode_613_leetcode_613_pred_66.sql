-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO point (x) VALUES (5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT X - LX AS SHORTEST FROM (SELECT X, LAG(X) OVER (ORDER BY X ASC) AS LX FROM POINT) AS A WHERE NOT LX IS NULL ORDER BY X - LX ASC, SHORTEST NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
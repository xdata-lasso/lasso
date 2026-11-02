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
SELECT Y - X AS SHORTEST FROM (SELECT X, LEAD(X) OVER () AS Y FROM POINT ORDER BY X ASC) AS T WHERE NOT Y IS NULL ORDER BY Y - X, SHORTEST NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
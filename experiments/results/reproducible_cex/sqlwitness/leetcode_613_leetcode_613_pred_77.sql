-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (A.NEXT_POINT - A.X) AS SHORTEST FROM (SELECT X, LEAD(X, 1) OVER (ORDER BY X) AS NEXT_POINT FROM POINT ORDER BY X ASC) AS A WHERE NOT (A.NEXT_POINT - A.X) IS NULL ORDER BY SHORTEST LIMIT 1;

/*
Prediction Result:
*/
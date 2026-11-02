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
SELECT ABS(X2.X - X1.X) AS SHORTEST FROM POINT AS X1 JOIN POINT AS X2 ON X1.X <> X2.X ORDER BY 1, X1.x NULLS LAST, X2.x NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
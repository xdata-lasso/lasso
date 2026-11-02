-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO point (x) VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SHORTEST FROM (SELECT ABS(X - LEAD(X) OVER (ORDER BY X)) AS SHORTEST FROM POINT) AS T WHERE NOT SHORTEST IS NULL ORDER BY SHORTEST LIMIT 1;

/*
Prediction Result:
*/
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
WITH CTE AS (SELECT A.X AS A_X, B.X AS B_X, CASE WHEN (A.X > 0 AND B.X > 0) OR (A.X < 0 AND B.X < 0) THEN ABS(ABS(A.X) - ABS(B.X)) ELSE ABS(ABS(A.X) + ABS(B.X)) END AS DIFF FROM POINT AS A CROSS JOIN POINT AS B WHERE A.X <> B.X) SELECT DIFF AS SHORTEST FROM CTE ORDER BY SHORTEST LIMIT 1;

/*
Prediction Result:
*/
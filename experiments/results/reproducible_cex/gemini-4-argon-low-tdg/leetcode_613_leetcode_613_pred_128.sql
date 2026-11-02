-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
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
SELECT DISTINCT ABS(A.X - B.X) AS SHORTEST FROM POINT AS A CROSS JOIN POINT AS B WHERE A.X <> B.X ORDER BY SHORTEST ASC LIMIT 1;

/*
Prediction Result:
*/
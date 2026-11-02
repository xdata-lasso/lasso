-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO point (x) VALUES (42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH POINT1 AS (SELECT X FROM POINT ORDER BY X), POINT2 AS (SELECT X FROM POINT ORDER BY X LIMIT 1234566 OFFSET 1) SELECT ABS(P2.X - P1.X) AS SHORTEST FROM POINT1 AS P1 CROSS JOIN POINT2 AS P2 WHERE ABS(P2.X - P1.X) > 0 ORDER BY SHORTEST LIMIT 1;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-545);
INSERT INTO "point" ("x") VALUES (-544);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT X, ABS((LAG(X, 1) OVER ()) - X) AS DISTANCE FROM POINT ORDER BY X) SELECT MIN(DISTANCE) AS SHORTEST FROM CTE;

/*
Prediction Result:
(1,)
*/
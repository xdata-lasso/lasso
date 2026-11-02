-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-865237337029958553);
INSERT INTO "point" ("x") VALUES (-865237337029956440);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(2113,)
*/

-- Prediction Query
WITH DIST AS (SELECT ABS(LAG(X) OVER () - X) AS DIFFERENCE FROM POINT) SELECT MIN(DIFFERENCE) AS SHORTEST FROM DIST;

/*
Prediction Result:
(2113,)
*/
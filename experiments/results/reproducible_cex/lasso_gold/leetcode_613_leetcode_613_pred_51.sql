-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-10);
INSERT INTO "point" ("x") VALUES (1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(1025,)
*/

-- Prediction Query
SELECT MIN(ABS(ABS(A.X) - ABS(A.NEXT_CLOSEST))) AS SHORTEST FROM (SELECT *, LEAD(X) OVER (ORDER BY X) AS NEXT_CLOSEST FROM POINT) AS A;

/*
Prediction Result:
(1005,)
*/
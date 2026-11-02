-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-3281);
INSERT INTO "point" ("x") VALUES (906);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(4187,)
*/

-- Prediction Query
SELECT MIN(DIST) AS SHORTEST FROM (SELECT ABS(X - X1) AS DIST FROM (SELECT A.X, A.ROW_NUM, B.X AS X1, B.ROW_NUM AS ROW_NUM1 FROM (SELECT X, ROW_NUMBER() OVER (ORDER BY X) AS ROW_NUM FROM POINT) AS A CROSS JOIN (SELECT X, ROW_NUMBER() OVER (ORDER BY X) AS ROW_NUM FROM POINT) AS B) AS C WHERE ROW_NUM <> ROW_NUM1) AS D;

/*
Prediction Result:
(4187,)
*/
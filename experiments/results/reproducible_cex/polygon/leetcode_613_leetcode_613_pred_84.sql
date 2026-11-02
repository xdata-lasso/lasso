-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (578);
INSERT INTO "point" ("x") VALUES (4156);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(3578,)
*/

-- Prediction Query
SELECT MIN(ABS(TEMP.A - TEMP.B)) AS SHORTEST FROM (SELECT P.X AS A, J.X AS B FROM POINT AS P CROSS JOIN POINT AS J ON P.X <> J.X) AS TEMP;

/*
Prediction Result:
(3578,)
*/
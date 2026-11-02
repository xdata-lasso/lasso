-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (111);
INSERT INTO "point" ("x") VALUES (1778);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(1667,)
*/

-- Prediction Query
SELECT MIN(ABS(P1.X - P2.X)) AS SHORTEST FROM POINT AS P1 CROSS JOIN POINT AS P2 ON P1.X <> P2.X;

/*
Prediction Result:
(1667,)
*/
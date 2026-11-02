-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-416);
INSERT INTO "point" ("x") VALUES (3219);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(3635,)
*/

-- Prediction Query
SELECT SHORTEST FROM (SELECT ABS((A.X - B.X)) AS SHORTEST FROM POINT AS A CROSS JOIN POINT AS B) AS D WHERE SHORTEST <> 0 ORDER BY SHORTEST LIMIT 1;

/*
Prediction Result:
(3635,)
*/
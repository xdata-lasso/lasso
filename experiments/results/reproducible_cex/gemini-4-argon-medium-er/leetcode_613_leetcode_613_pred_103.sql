-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO point (x) VALUES (1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTANCE AS SHORTEST FROM (SELECT ABS(P1.X - P2.X) AS DISTANCE FROM POINT AS P1 JOIN POINT AS P2 ON P1.X <> P2.X) AS TMP ORDER BY DISTANCE ASC, SHORTEST NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
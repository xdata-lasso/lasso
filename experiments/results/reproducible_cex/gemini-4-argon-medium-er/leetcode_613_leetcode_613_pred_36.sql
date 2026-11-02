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
SELECT DISTINCT ABS(P1.X - P2.X) AS SHORTEST FROM POINT AS P1 CROSS JOIN POINT AS P2 WHERE ABS(P1.X - P2.X) > 0 ORDER BY ABS(P1.X - P2.X), SHORTEST NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
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
SELECT ABS(PT1.X - PT2.X) AS SHORTEST FROM POINT AS PT1 JOIN POINT AS PT2 ON PT1.X <> PT2.X ORDER BY SHORTEST, PT1.x NULLS LAST, PT2.x NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
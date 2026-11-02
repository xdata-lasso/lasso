-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ABS(A.X - B.X) AS SHORTEST FROM POINT AS A JOIN POINT AS B ON A.X < B.X ORDER BY SHORTEST, A.x NULLS LAST, B.x NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
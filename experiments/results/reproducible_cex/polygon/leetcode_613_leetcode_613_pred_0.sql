-- Schema DDL
CREATE TABLE "point" ("x" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "point" ("x") VALUES (-788);
INSERT INTO "point" ("x") VALUES (-416);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(ABS((a.x - b.x))) AS shortest FROM point AS a CROSS JOIN point AS b WHERE a.x <> b.x;

/*
Gold Result:
(372,)
*/

-- Prediction Query
SELECT ABS(P1.X - P2.X) AS SHORTEST FROM POINT AS P1 CROSS JOIN POINT AS P2 WHERE P1.X <> P2.X ORDER BY SHORTEST, P1.x NULLS LAST, P2.x NULLS LAST LIMIT 1;

/*
Prediction Result:
(372,)
*/
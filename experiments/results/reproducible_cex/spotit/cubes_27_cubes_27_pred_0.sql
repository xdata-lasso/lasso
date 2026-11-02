-- Schema DDL
CREATE TABLE "I037" (
    "C1" INT,
    "C2" TEXT,
    "C3" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I037 VALUES (-1, -1, 0);
INSERT INTO I037 VALUES (-2, -1, 47);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c1, c2, c3 FROM (SELECT LHS.c2 AS c2, LHS.c1 AS c1, RHS.c3 AS c3 FROM (SELECT c2, MIN(c1) AS c1 FROM i037 GROUP BY c2) AS LHS LEFT JOIN i037 AS RHS ON (LHS.c2 = RHS.c2 AND LHS.c1 = RHS.c1)) ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(-2, '-1', '47')
*/

-- Prediction Query
SELECT t1.*, i037.c3 FROM (SELECT c2, MIN(c1) AS minc1 FROM i037 GROUP BY c2) AS t1 JOIN i037 ON t1.minc1 = i037.c1;

/*
Prediction Result:
('-1', -2, '47')
*/
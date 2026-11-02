-- Schema DDL
CREATE TABLE "i037" ("c1" INTEGER, "c2" TEXT, "c3" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i037 (c1, c2, c3) VALUES (10, 'alpha', 'a_min');
INSERT INTO i037 (c1, c2, c3) VALUES (25, 'alpha', 'a_max');
INSERT INTO i037 (c1, c2, c3) VALUES (-5, 'beta', 'b_min');
INSERT INTO i037 (c1, c2, c3) VALUES (0, 'beta', 'b_mid');
INSERT INTO i037 (c1, c2, c3) VALUES (5, 'beta', 'b_max');
INSERT INTO i037 (c1, c2, c3) VALUES (0, 'gamma', 'g_only');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c1, c2, c3 FROM (SELECT LHS.c2 AS c2, LHS.c1 AS c1, RHS.c3 AS c3 FROM (SELECT c2, MIN(c1) AS c1 FROM i037 GROUP BY c2) AS LHS LEFT JOIN i037 AS RHS ON (LHS.c2 = RHS.c2 AND LHS.c1 = RHS.c1)) ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(-5, 'beta', 'b_min')
(0, 'gamma', 'g_only')
(10, 'alpha', 'a_min')
*/

-- Prediction Query
SELECT t1.*, i037.c3 FROM (SELECT c2, MIN(c1) AS minc1 FROM i037 GROUP BY c2) AS t1 JOIN i037 ON t1.minc1 = i037.c1;

/*
Prediction Result:
('alpha', 10, 'a_min')
('beta', -5, 'b_min')
('gamma', 0, 'b_mid')
('gamma', 0, 'g_only')
*/
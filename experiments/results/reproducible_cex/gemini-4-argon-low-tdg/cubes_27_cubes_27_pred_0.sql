-- Schema DDL
CREATE TABLE "i037" ("c1" INTEGER, "c2" TEXT, "c3" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO i037 (c1, c2, c3) VALUES (10, NULL, 'null_c2_min');
INSERT INTO i037 (c1, c2, c3) VALUES (20, NULL, 'null_c2_max');
INSERT INTO i037 (c1, c2, c3) VALUES (NULL, 'C', 'null_c1_only');
INSERT INTO i037 (c1, c2, c3) VALUES (NULL, 'D', 'null_c1_with_nonnull');
INSERT INTO i037 (c1, c2, c3) VALUES (15, 'D', 'nonnull_c1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c1, c2, c3 FROM (SELECT LHS.c2 AS c2, LHS.c1 AS c1, RHS.c3 AS c3 FROM (SELECT c2, MIN(c1) AS c1 FROM i037 GROUP BY c2) AS LHS LEFT JOIN i037 AS RHS ON (LHS.c2 = RHS.c2 AND LHS.c1 = RHS.c1)) ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(None, 'C', None)
(10, None, None)
(15, 'D', 'nonnull_c1')
*/

-- Prediction Query
SELECT t1.*, i037.c3 FROM (SELECT c2, MIN(c1) AS minc1 FROM i037 GROUP BY c2) AS t1 JOIN i037 ON t1.minc1 = i037.c1;

/*
Prediction Result:
(None, 10, 'null_c2_min')
('D', 15, 'nonnull_c1')
*/
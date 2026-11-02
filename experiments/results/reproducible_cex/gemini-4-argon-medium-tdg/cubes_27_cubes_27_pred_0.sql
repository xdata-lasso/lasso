-- Schema DDL
CREATE TABLE "i037" ("c1" INTEGER, "c2" TEXT, "c3" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i037 (c1, c2, c3) VALUES (10, 'A', 'first_A');
INSERT INTO i037 (c1, c2, c3) VALUES (20, 'A', 'second_A');
INSERT INTO i037 (c1, c2, c3) VALUES (5, 'B', 'only_B');
INSERT INTO i037 (c1, c2, c3) VALUES (15, 'B', 'high_B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c1, c2, c3 FROM (SELECT LHS.c2 AS c2, LHS.c1 AS c1, RHS.c3 AS c3 FROM (SELECT c2, MIN(c1) AS c1 FROM i037 GROUP BY c2) AS LHS LEFT JOIN i037 AS RHS ON (LHS.c2 = RHS.c2 AND LHS.c1 = RHS.c1)) ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(5, 'B', 'only_B')
(10, 'A', 'first_A')
*/

-- Prediction Query
SELECT t1.*, i037.c3 FROM (SELECT c2, MIN(c1) AS minc1 FROM i037 GROUP BY c2) AS t1 JOIN i037 ON t1.minc1 = i037.c1;

/*
Prediction Result:
('A', 10, 'first_A')
('B', 5, 'only_B')
*/
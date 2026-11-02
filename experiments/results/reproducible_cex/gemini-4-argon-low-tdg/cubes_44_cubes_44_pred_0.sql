-- Schema DDL
CREATE TABLE "i044" ("id" INTEGER, "count" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO i044 (id, count) VALUES (1, NULL);
INSERT INTO i044 (id, count) VALUES (1, 10);
INSERT INTO i044 (id, count) VALUES (1, 5);
INSERT INTO i044 (id, count) VALUES (2, NULL);
INSERT INTO i044 (id, count) VALUES (2, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, COUNT, SUM(COUNT) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sumcount FROM i044 ORDER BY id, i044.count NULLS LAST;

/*
Gold Result:
(1, 5, 15)
(1, 10, 10)
(1, None, None)
(2, 20, 35)
(2, None, 15)
*/

-- Prediction Query
SELECT t.id, t.count, (SELECT SUM(x.count) FROM i044 AS x WHERE x.id <= t.id) AS cumulative_sum FROM i044 AS t ORDER BY t.id, t.count NULLS LAST;

/*
Prediction Result:
(1, 5, 15)
(1, 10, 15)
(1, None, 15)
(2, 20, 35)
(2, None, 35)
*/
-- Schema DDL
CREATE TABLE "i044" ("id" INTEGER, "count" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i044 (id, count) VALUES (1, 1);
INSERT INTO i044 (id, count) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, COUNT, SUM(COUNT) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sumcount FROM i044 ORDER BY id, i044.count NULLS LAST;

/*
Gold Result:
(1, 1, 1)
(1, 2, 3)
*/

-- Prediction Query
SELECT t.id, t.count, (SELECT SUM(x.count) FROM i044 AS x WHERE x.id <= t.id) AS cumulative_sum FROM i044 AS t ORDER BY t.id, t.count NULLS LAST;

/*
Prediction Result:
(1, 1, 3)
(1, 2, 3)
*/
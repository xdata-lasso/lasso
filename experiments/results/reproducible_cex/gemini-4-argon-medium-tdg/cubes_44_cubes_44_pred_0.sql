-- Schema DDL
CREATE TABLE "i044" ("id" INTEGER, "count" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i044 (id, count) VALUES (2, 10);
INSERT INTO i044 (id, count) VALUES (1, 20);
INSERT INTO i044 (id, count) VALUES (1, NULL);
INSERT INTO i044 (id, count) VALUES (1, 5);
INSERT INTO i044 (id, count) VALUES (NULL, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, COUNT, SUM(COUNT) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sumcount FROM i044 ORDER BY id, i044.count NULLS LAST;

/*
Gold Result:
(None, 15, 50)
(1, 5, 35)
(1, 20, 30)
(1, None, 30)
(2, 10, 10)
*/

-- Prediction Query
SELECT t.id, t.count, (SELECT SUM(x.count) FROM i044 AS x WHERE x.id <= t.id) AS cumulative_sum FROM i044 AS t ORDER BY t.id, t.count NULLS LAST;

/*
Prediction Result:
(None, 15, None)
(1, 5, 25)
(1, 20, 25)
(1, None, 25)
(2, 10, 35)
*/
-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, group_id INTEGER, value INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO T1 (id, group_id, value) VALUES (1, 10, 100);
INSERT INTO T1 (id, group_id, value) VALUES (2, 20, NULL);
INSERT INTO T1 (id, group_id, value) VALUES (3, 30, 50);
INSERT INTO T1 (id, group_id, value) VALUES (4, 30, 50);
INSERT INTO T1 (id, group_id, value) VALUES (5, 40, 60);
INSERT INTO T1 (id, group_id, value) VALUES (6, 40, 70);
INSERT INTO T1 (id, group_id, value) VALUES (7, 50, NULL);
INSERT INTO T1 (id, group_id, value) VALUES (8, 50, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT group_id FROM T1 GROUP BY group_id HAVING COUNT(DISTINCT value) > 0;

/*
Gold Result:
(10,)
(30,)
(40,)
(50,)
*/

-- Prediction Query
WITH distinct_vals AS (SELECT DISTINCT group_id, value FROM T1) SELECT group_id FROM distinct_vals GROUP BY group_id HAVING COUNT(*) > 0;

/*
Prediction Result:
(10,)
(20,)
(30,)
(40,)
(50,)
*/
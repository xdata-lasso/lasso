-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, group_id INTEGER, value INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic NULL handling in HAVING COUNT(DISTINCT value) > 0 vs COUNT(*) > 0 or missing HAVING
-- Also tests duplicate values in a group (COUNT(value) = 2 vs COUNT(DISTINCT value) = 1)
INSERT INTO T1 (id, group_id, value) VALUES (1, 10, NULL);
INSERT INTO T1 (id, group_id, value) VALUES (2, 10, NULL);
INSERT INTO T1 (id, group_id, value) VALUES (3, 20, 5);
INSERT INTO T1 (id, group_id, value) VALUES (4, 20, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT group_id FROM T1 GROUP BY group_id HAVING COUNT(DISTINCT value) > 0;

/*
Gold Result:
(20,)
*/

-- Prediction Query
WITH distinct_vals AS (SELECT DISTINCT group_id, value FROM T1) SELECT group_id FROM distinct_vals GROUP BY group_id HAVING COUNT(*) > 0;

/*
Prediction Result:
(10,)
(20,)
*/
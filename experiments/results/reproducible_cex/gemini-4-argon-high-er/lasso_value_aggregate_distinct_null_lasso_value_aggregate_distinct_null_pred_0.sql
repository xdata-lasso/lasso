-- Schema DDL
CREATE TABLE T1 (id INTEGER PRIMARY KEY, group_id INTEGER, value INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO T1 (id, group_id, value) VALUES (1, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT group_id FROM T1 GROUP BY group_id HAVING COUNT(DISTINCT value) > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH distinct_vals AS (SELECT DISTINCT group_id, value FROM T1) SELECT group_id FROM distinct_vals GROUP BY group_id HAVING COUNT(*) > 0;

/*
Prediction Result:
(10,)
*/
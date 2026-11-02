-- Schema DDL
CREATE TABLE partsupp (ps_id INTEGER PRIMARY KEY, ps_cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the minimum cost, distinct non-minimum costs, and NULL handling.
-- Kills mutants using LIMIT 1, MAX instead of MIN, wrong comparison operators (<, >, <=, >=, !=), or IS NULL.
INSERT INTO partsupp (ps_id, ps_cost) VALUES (1, 10.5);
INSERT INTO partsupp (ps_id, ps_cost) VALUES (2, 20.0);
INSERT INTO partsupp (ps_id, ps_cost) VALUES (3, 10.5);
INSERT INTO partsupp (ps_id, ps_cost) VALUES (4, 30.25);
INSERT INTO partsupp (ps_id, ps_cost) VALUES (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ps_id FROM partsupp WHERE ps_cost = (SELECT MIN(ps_cost) FROM partsupp);

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT ps_id FROM partsupp;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/
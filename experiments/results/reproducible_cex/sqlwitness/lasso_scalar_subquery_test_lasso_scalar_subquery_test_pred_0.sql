-- Schema DDL
CREATE TABLE partsupp (ps_id INTEGER PRIMARY KEY, ps_cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO partsupp (ps_id, ps_cost) VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ps_id FROM partsupp WHERE ps_cost = (SELECT MIN(ps_cost) FROM partsupp);

/*
Gold Result:
*/

-- Prediction Query
SELECT ps_id FROM partsupp;

/*
Prediction Result:
(0,)
*/
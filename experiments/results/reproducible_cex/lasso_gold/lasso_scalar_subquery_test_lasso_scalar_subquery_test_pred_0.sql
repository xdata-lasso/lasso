-- Schema DDL
CREATE TABLE partsupp (ps_id INTEGER PRIMARY KEY, ps_cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (1003, 1006.5);
INSERT INTO "partsupp" ("ps_id", "ps_cost") VALUES (1005, 1009.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ps_id FROM partsupp WHERE ps_cost = (SELECT MIN(ps_cost) FROM partsupp);

/*
Gold Result:
(1003,)
*/

-- Prediction Query
SELECT ps_id FROM partsupp;

/*
Prediction Result:
(1003,)
(1005,)
*/
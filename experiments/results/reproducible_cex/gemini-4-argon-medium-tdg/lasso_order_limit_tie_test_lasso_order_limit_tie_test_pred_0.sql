-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, score INTEGER, val REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO items (id, score, val) VALUES (10, 50, 100.25);
INSERT INTO items (id, score, val) VALUES (5, 50, 200.75);
INSERT INTO items (id, score, val) VALUES (20, 30, 300.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM items ORDER BY score DESC, items.id NULLS LAST LIMIT 1;

/*
Gold Result:
(200.75,)
*/

-- Prediction Query
SELECT val FROM items WHERE score = (SELECT MAX(score) FROM items);

/*
Prediction Result:
(200.75,)
(100.25,)
*/
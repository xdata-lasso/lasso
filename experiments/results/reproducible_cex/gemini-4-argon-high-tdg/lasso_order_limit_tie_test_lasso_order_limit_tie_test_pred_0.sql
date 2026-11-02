-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, score INTEGER, val REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, score, val) VALUES (1, 50, 500.25);
INSERT INTO items (id, score, val) VALUES (5, 100, 10.5);
INSERT INTO items (id, score, val) VALUES (2, 100, 42.75);
INSERT INTO items (id, score, val) VALUES (3, 100, 99.9);
INSERT INTO items (id, score, val) VALUES (4, 10, 1.25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM items ORDER BY score DESC, items.id NULLS LAST LIMIT 1;

/*
Gold Result:
(42.75,)
*/

-- Prediction Query
SELECT val FROM items WHERE score = (SELECT MAX(score) FROM items);

/*
Prediction Result:
(42.75,)
(99.9,)
(10.5,)
*/
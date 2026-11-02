-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, val, score) VALUES (1, 1.5, 100.0);
INSERT INTO items (id, val, score) VALUES (2, 3.0, 200.0);
INSERT INTO items (id, val, score) VALUES (3, 5.5, 300.0);
INSERT INTO items (id, val, score) VALUES (4, 7.0, 400.0);
INSERT INTO items (id, val, score) VALUES (5, 9.5, 500.0);
INSERT INTO items (id, val, score) VALUES (6, 11.0, 600.0);
INSERT INTO items (id, val, score) VALUES (7, 13.5, 700.0);
INSERT INTO items (id, val, score) VALUES (8, 15.0, 800.0);
INSERT INTO items (id, val, score) VALUES (9, 17.5, 900.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(3.5,)
(2.75,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(400.0,)
(300.0,)
(200.0,)
(100.0,)
*/
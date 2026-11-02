-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, val, score) VALUES (1, 10.0, 1.0);
INSERT INTO items (id, val, score) VALUES (2, 10.0, 1.0);
INSERT INTO items (id, val, score) VALUES (3, 10.0, 1.0);
INSERT INTO items (id, val, score) VALUES (4, 10.0, 1.0);
INSERT INTO items (id, val, score) VALUES (5, 10.0, 1.0);
INSERT INTO items (id, val, score) VALUES (6, 10.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(5.0,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(1.0,)
*/
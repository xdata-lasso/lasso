-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, val, score) VALUES (1, 100.0, 10.0);
INSERT INTO items (id, val, score) VALUES (2, 90.0, 20.0);
INSERT INTO items (id, val, score) VALUES (3, 80.0, 30.0);
INSERT INTO items (id, val, score) VALUES (4, 70.0, 40.0);
INSERT INTO items (id, val, score) VALUES (5, 60.0, 50.0);
INSERT INTO items (id, val, score) VALUES (6, 51.0, 60.0);
INSERT INTO items (id, val, score) VALUES (7, 43.0, 70.0);
INSERT INTO items (id, val, score) VALUES (8, 30.0, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(25.5,)
(21.5,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(60.0,)
(70.0,)
(80.0,)
*/
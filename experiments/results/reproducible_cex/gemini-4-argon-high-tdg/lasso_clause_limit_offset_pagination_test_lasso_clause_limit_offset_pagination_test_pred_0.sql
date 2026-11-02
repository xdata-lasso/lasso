-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, val, score) VALUES (10, 95.5, 10.0);
INSERT INTO items (id, val, score) VALUES (3, 82.0, 90.0);
INSERT INTO items (id, val, score) VALUES (7, 71.25, 20.5);
INSERT INTO items (id, val, score) VALUES (1, 60.0, 80.0);
INSERT INTO items (id, val, score) VALUES (9, 45.75, 30.0);
INSERT INTO items (id, val, score) VALUES (4, 33.5, 70.25);
INSERT INTO items (id, val, score) VALUES (8, 19.25, 40.0);
INSERT INTO items (id, val, score) VALUES (2, 5.0, 60.5);
INSERT INTO items (id, val, score) VALUES (6, -12.5, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(16.75,)
(9.625,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(70.25,)
(40.0,)
(60.5,)
(50.0,)
*/
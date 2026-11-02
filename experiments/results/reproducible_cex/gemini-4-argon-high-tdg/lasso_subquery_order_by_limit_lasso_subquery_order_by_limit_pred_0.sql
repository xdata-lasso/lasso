-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val_a INTEGER, val_b INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, val_a, val_b, name) VALUES (1, 30, 10, 'd_row');
INSERT INTO items (id, val_a, val_b, name) VALUES (2, 40, 20, 'c_row');
INSERT INTO items (id, val_a, val_b, name) VALUES (3, 10, 30, 'b_row');
INSERT INTO items (id, val_a, val_b, name) VALUES (4, 20, 40, 'a_row');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM items ORDER BY val_a DESC, items.id NULLS LAST LIMIT 1);

/*
Gold Result:
('c_row',)
*/

-- Prediction Query
SELECT name FROM (SELECT * FROM items ORDER BY val_b DESC, items.id NULLS LAST LIMIT 1);

/*
Prediction Result:
('a_row',)
*/
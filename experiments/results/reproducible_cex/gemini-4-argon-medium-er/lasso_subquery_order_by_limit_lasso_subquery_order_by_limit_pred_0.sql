-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val_a INTEGER, val_b INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, val_a, val_b, name) VALUES (1, 10, 1, 'A');
INSERT INTO items (id, val_a, val_b, name) VALUES (2, 1, 10, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM items ORDER BY val_a DESC, items.id NULLS LAST LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT name FROM (SELECT * FROM items ORDER BY val_b DESC, items.id NULLS LAST LIMIT 1);

/*
Prediction Result:
('B',)
*/
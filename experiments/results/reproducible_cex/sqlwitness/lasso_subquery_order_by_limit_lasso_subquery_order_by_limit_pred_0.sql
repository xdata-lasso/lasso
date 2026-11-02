-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val_a INTEGER, val_b INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, val_a, val_b, name) VALUES (0, 2, NULL, 'default2'), (2, 1, 0, NULL), (1, 0, 2, 'default1'), (3, 0, 1, 'default1'), (4, NULL, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM items ORDER BY val_a DESC, items.id NULLS LAST LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT name FROM (SELECT * FROM items ORDER BY val_b DESC, items.id NULLS LAST LIMIT 1);

/*
Prediction Result:
('default1',)
*/
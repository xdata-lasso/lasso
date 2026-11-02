-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val_a INTEGER, val_b INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, val_a, val_b, name) VALUES (1, 10, 50, 'Item_Low_A');
INSERT INTO items (id, val_a, val_b, name) VALUES (2, 30, 10, 'Item_High_A_Low_ID');
INSERT INTO items (id, val_a, val_b, name) VALUES (3, 30, 90, 'Item_High_A_High_ID');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM items ORDER BY val_a DESC, items.id NULLS LAST LIMIT 1);

/*
Gold Result:
('Item_High_A_Low_ID',)
*/

-- Prediction Query
SELECT name FROM (SELECT * FROM items ORDER BY val_b DESC, items.id NULLS LAST LIMIT 1);

/*
Prediction Result:
('Item_High_A_High_ID',)
*/
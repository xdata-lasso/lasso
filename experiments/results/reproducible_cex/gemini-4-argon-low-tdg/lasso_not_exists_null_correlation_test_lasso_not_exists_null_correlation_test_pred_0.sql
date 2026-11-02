-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cat TEXT, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in both 'cat' and 'status' columns (catches NOT IN vs NOT EXISTS bugs and IS NULL omissions).
INSERT INTO items (id, cat, status) VALUES (1, NULL, 'active');
INSERT INTO items (id, cat, status) VALUES (2, NULL, 'inactive');
INSERT INTO items (id, cat, status) VALUES (3, 'Toys', NULL);
INSERT INTO items (id, cat, status) VALUES (4, 'Games', 'active');
INSERT INTO items (id, cat, status) VALUES (5, 'Games', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cat FROM items AS a WHERE NOT EXISTS(SELECT 1 FROM items AS b WHERE a.cat = b.cat AND b.status = 'active');

/*
Gold Result:
(None,)
('Toys',)
*/

-- Prediction Query
SELECT cat FROM items EXCEPT SELECT cat FROM items WHERE status = 'active';

/*
Prediction Result:
('Toys',)
*/
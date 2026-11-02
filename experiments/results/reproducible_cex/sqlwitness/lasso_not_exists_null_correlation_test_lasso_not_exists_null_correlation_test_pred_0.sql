-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cat TEXT, status TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, cat, status) VALUES (1, 'default2', 'default1'), (2, 'default2', 'active'), (0, NULL, 'active'), (3, 'default2', 'active'), (4, 'default1', 'default2'), (5, NULL, 'default2'), (6, 'default2', 'default1'), (7, 'active', 'default1'), (8, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cat FROM items AS a WHERE NOT EXISTS(SELECT 1 FROM items AS b WHERE a.cat = b.cat AND b.status = 'active');

/*
Gold Result:
(None,)
('default1',)
('active',)
*/

-- Prediction Query
SELECT cat FROM items EXCEPT SELECT cat FROM items WHERE status = 'active';

/*
Prediction Result:
('active',)
('default1',)
*/
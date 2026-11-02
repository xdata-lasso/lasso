-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, val, score) VALUES (9, 4.0, 5.0), (1, NULL, 3.0), (3, 1.0, 4.0), (4, 9.0, 4.0), (2, 9.0, 4.0), (10, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(0.0,)
*/
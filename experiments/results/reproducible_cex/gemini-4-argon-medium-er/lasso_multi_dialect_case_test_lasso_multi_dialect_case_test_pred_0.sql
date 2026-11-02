-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO items (id, cost) VALUES (1, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM items WHERE cost > 10.0;

/*
Gold Result:
*/

-- Prediction Query
SELECT id FROM items WHERE cost >= 10.0;

/*
Prediction Result:
(1,)
*/
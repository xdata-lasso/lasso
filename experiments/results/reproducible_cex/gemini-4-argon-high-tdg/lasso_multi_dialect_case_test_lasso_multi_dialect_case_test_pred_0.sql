-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, cost) VALUES (1, 9.99);
INSERT INTO items (id, cost) VALUES (2, 10.0);
INSERT INTO items (id, cost) VALUES (3, 10.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM items WHERE cost > 10.0;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT id FROM items WHERE cost >= 10.0;

/*
Prediction Result:
(2,)
(3,)
*/
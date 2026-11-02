-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, cost REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO items (id, cost) VALUES (1, 10.0);
INSERT INTO items (id, cost) VALUES (2, 10.0001);
INSERT INTO items (id, cost) VALUES (3, 9.9999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM items WHERE cost > 10.0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT id FROM items WHERE cost >= 10.0;

/*
Prediction Result:
(1,)
(2,)
*/
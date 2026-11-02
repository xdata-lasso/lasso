-- Schema DDL
CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO products (id, name) VALUES (1, 'App');
INSERT INTO products (id, name) VALUES (2, 'Apxp');
INSERT INTO products (id, name) VALUES (3, 'Ap');
INSERT INTO products (id, name) VALUES (4, 'App!');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE name LIKE 'App%';

/*
Gold Result:
('App',)
('App!',)
*/

-- Prediction Query
SELECT name FROM products WHERE name = 'App%';

/*
Prediction Result:
*/
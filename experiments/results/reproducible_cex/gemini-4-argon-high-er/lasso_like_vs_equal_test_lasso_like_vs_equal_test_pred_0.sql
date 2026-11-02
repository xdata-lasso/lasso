-- Schema DDL
CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (id, name) VALUES (1, 'Apple');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE name LIKE 'App%';

/*
Gold Result:
('Apple',)
*/

-- Prediction Query
SELECT name FROM products WHERE name = 'App%';

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO products (id, name) VALUES (1, 'App');
INSERT INTO products (id, name) VALUES (2, 'Apps');
INSERT INTO products (id, name) VALUES (3, 'Apple');
INSERT INTO products (id, name) VALUES (4, 'MyApp');
INSERT INTO products (id, name) VALUES (5, 'Snapple');
INSERT INTO products (id, name) VALUES (6, 'Banana');
INSERT INTO products (id, name) VALUES (7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE name LIKE 'App%';

/*
Gold Result:
('App',)
('Apps',)
('Apple',)
*/

-- Prediction Query
SELECT name FROM products WHERE name = 'App%';

/*
Prediction Result:
*/
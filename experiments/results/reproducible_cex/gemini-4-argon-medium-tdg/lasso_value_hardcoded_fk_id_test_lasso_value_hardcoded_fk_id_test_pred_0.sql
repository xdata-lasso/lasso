-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO categories (id, name) VALUES (1, 'Electronics');
INSERT INTO categories (id, name) VALUES (2, 'Books');
INSERT INTO categories (id, name) VALUES (3, 'electronics');
INSERT INTO products (id, cat_id, title) VALUES (1, 2, 'Laptop');
INSERT INTO products (id, cat_id, title) VALUES (2, 1, 'Smartphone');
INSERT INTO products (id, cat_id, title) VALUES (3, 1, 'Smartphone');
INSERT INTO products (id, cat_id, title) VALUES (4, NULL, 'Tablet');
INSERT INTO products (id, cat_id, title) VALUES (5, 3, 'Headphones');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
('Smartphone',)
('Smartphone',)
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/
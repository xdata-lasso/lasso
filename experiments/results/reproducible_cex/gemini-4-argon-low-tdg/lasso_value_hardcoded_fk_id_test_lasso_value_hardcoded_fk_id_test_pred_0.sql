-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO categories (id, name) VALUES (1, 'Electronics');
INSERT INTO categories (id, name) VALUES (2, 'Books');
INSERT INTO categories (id, name) VALUES (3, 'Clothing');
INSERT INTO products (id, cat_id, title) VALUES (10, 1, 'Smartphone');
INSERT INTO products (id, cat_id, title) VALUES (20, 1, 'Smartphone');
INSERT INTO products (id, cat_id, title) VALUES (30, 1, 'Laptop');
INSERT INTO products (id, cat_id, title) VALUES (40, 2, 'Novel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
('Smartphone',)
('Smartphone',)
('Laptop',)
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/
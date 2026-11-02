-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO categories (id, name) VALUES (10, 'Electronics');
INSERT INTO categories (id, name) VALUES (20, 'Books');
INSERT INTO products (id, cat_id, title) VALUES (10, 20, 'Novel');
INSERT INTO products (id, cat_id, title) VALUES (20, 10, 'Laptop');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
('Laptop',)
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/
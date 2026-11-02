-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO categories (id, name) VALUES (7, NULL);
INSERT INTO products (id, cat_id, title) VALUES (0, 7, 'Electronics');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
('Electronics',)
*/
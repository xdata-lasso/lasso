-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, rating REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, product_name, category, rating) VALUES (0, 'default1', 'default1', NULL), (1, 'default2', 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(product_id) FROM Products;

/*
Prediction Result:
(2,)
*/
-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, rating REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, product_name, category, rating) VALUES (1, 'Laptop', 'Electronics', 4.5);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (2, 'Mouse', 'Electronics', 4.5);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (3, 'Desk', 'Furniture', NULL);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (4, NULL, NULL, 3.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Products;

/*
Prediction Result:
(4,)
*/
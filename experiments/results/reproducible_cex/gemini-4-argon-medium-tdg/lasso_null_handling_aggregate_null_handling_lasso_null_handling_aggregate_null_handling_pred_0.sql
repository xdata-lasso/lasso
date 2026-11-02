-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, rating REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, product_name, category, rating) VALUES (1, 'Laptop', 'Electronics', 4.5);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (2, 'Mouse', 'Electronics', 4.5);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (3, 'Desk', 'Furniture', NULL);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (4, 'Chair', NULL, 3.0);
INSERT INTO Products (product_id, product_name, category, rating) VALUES (5, NULL, 'Appliances', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Products;

/*
Prediction Result:
(5,)
*/
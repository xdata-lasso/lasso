-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, NULL, NULL, NULL, NULL);
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (2, 'Laptop', 'Electronics', 1200.50, '2023-01-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MAX(amount) FROM sales;

/*
Prediction Result:
(1200.5,)
*/
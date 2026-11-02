-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, NULL, 'default2', NULL, '2023-01-01'), (0, NULL, NULL, 1.0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MIN(amount) FROM sales;

/*
Prediction Result:
(1.0,)
*/
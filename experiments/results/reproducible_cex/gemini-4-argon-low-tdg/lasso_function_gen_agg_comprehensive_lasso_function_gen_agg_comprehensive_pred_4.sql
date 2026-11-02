-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard aggregation, DISTINCT mutations (COUNT/SUM/AVG(DISTINCT)), and grouping by wrong columns (product_name, sale_date).
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, 'Laptop', 'Electronics', 100.0, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (2, 'Mouse', 'Electronics', 100.0, '2023-01-02');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (3, 'Monitor', 'Electronics', 250.5, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (4, 'Desk', 'Furniture', 150.0, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (5, 'Desk', 'Furniture', 300.25, '2023-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('Electronics', 3, 450.5, 150.16666666666666, 250.5, 100.0)
('Furniture', 2, 450.25, 225.125, 300.25, 150.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales;

/*
Prediction Result:
('Electronics', 5, 900.75, 180.15, 300.25, 100.0)
*/
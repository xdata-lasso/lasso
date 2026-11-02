-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, 'Laptop', 'Electronics', 10.0, '2023-01-10');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (2, 'Mouse', 'Electronics', 10.0, '2023-01-11');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (3, 'Keyboard', 'Electronics', 25.0, '2023-01-12');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (4, 'Novel', 'Books', 5.0, '2023-01-10');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (5, 'Mouse', 'Books', 12.0, '2023-01-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('Books', 2, 17.0, 8.5, 12.0, 5.0)
('Electronics', 3, 45.0, 15.0, 25.0, 10.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
('Books', 2, 2, 8.5, 12.0, 5.0)
('Electronics', 3, 3, 15.0, 25.0, 10.0)
*/
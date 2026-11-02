-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, 'Laptop', 'Electronics', 100.0, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (2, 'Mouse', 'Electronics', 200.0, '2023-01-02');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (3, 'Monitor', 'Electronics', 600.0, '2023-01-03');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (4, 'Novel', 'Books', 10.5, '2023-01-04');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (5, 'Textbook', 'Books', 20.5, '2023-01-05');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (6, 'Chair', 'Furniture', 150.0, '2023-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('Books', 2, 31.0, 15.5, 20.5, 10.5)
('Electronics', 3, 900.0, 300.0, 600.0, 100.0)
('Furniture', 1, 150.0, 150.0, 150.0, 150.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
('Books', 2, 2, 15.5, 20.5, 10.5)
('Electronics', 3, 3, 300.0, 600.0, 100.0)
('Furniture', 1, 1, 150.0, 150.0, 150.0)
*/
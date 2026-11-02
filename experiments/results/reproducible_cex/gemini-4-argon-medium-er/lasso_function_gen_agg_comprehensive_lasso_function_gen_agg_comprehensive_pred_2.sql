-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (1, 'A', 'Cat1', 10.0, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (2, 'B', 'Cat1', 20.0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('Cat1', 2, 30.0, 15.0, 20.0, 10.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, MAX(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
('Cat1', 2, 30.0, 20.0, 20.0, 10.0)
*/
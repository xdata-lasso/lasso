-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (0, NULL, 'default2', 0.0, '2023-01-02'), (1, 'default2', 'default1', NULL, '2023-01-02'), (2, 'default1', NULL, NULL, NULL), (3, 'default1', 'default2', 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
(None, 0, None, None, None, None)
('default1', 0, None, None, None, None)
('default2', 2, 1.0, 0.5, 1.0, 0.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, MAX(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
(None, 0, None, None, None, None)
('default1', 0, None, None, None, None)
('default2', 2, 1.0, 1.0, 1.0, 0.0)
*/
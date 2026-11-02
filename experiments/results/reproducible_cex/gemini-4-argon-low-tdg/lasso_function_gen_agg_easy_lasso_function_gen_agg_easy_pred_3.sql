-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: COUNT(*) vs COUNT(col), COUNT(DISTINCT col), SUM(amount), AVG(amount), MAX(id), MIN(id), and spurious WHERE clauses (NULLs, negatives, zeros, empty strings).
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (10, 'Item A', 'Cat 1', 100.50, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (20, 'Item A', 'Cat 1', 0.0, '2023-01-01');
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (30, NULL, NULL, NULL, NULL);
INSERT INTO sales (id, product_name, category, amount, sale_date) VALUES (40, '', '', -50.25, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT AVG(amount) FROM sales;

/*
Prediction Result:
(16.75,)
*/
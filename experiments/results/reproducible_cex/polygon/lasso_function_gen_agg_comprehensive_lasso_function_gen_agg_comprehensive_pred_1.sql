-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (7, '1', NULL, 1, '1000-01-02');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (6, '1', '8', NULL, '1000-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
(None, 1, 1.0, 1.0, 1.0, 1.0)
('8', 0, None, None, None, None)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
(None, 1, 1, 1.0, 1.0, 1.0)
('8', 0, 0, None, None, None)
*/
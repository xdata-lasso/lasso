-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (7, '11075', NULL, 0, '1030-04-29');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (6, '11075', NULL, 11075, '1030-04-29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
(None, 2, 11075.0, 5537.5, 11075.0, 0.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, MAX(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
(None, 2, 11075.0, 11075.0, 11075.0, 0.0)
*/
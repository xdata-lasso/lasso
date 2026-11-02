-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (1026, 'Brandon Davis', 'throw', 1027.5, '1977-08-08');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (1028, 'Dennis Williams', 'machine', NULL, '1978-09-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('machine', 0, None, None, None, None)
('throw', 1, 1027.5, 1027.5, 1027.5, 1027.5)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales;

/*
Prediction Result:
('throw', 1, 1027.5, 1027.5, 1027.5, 1027.5)
*/
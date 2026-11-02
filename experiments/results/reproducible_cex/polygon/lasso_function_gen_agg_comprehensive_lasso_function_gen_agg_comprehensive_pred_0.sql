-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (7, '1', '9', 5530, '1000-01-02');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (6, '1', '8', 1, '1000-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('8', 1, 1.0, 1.0, 1.0, 1.0)
('9', 1, 5530.0, 5530.0, 5530.0, 5530.0)
*/

-- Prediction Query
SELECT category, SUM(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
('8', 1.0, 1.0, 1.0, 1.0, 1.0)
('9', 5530.0, 5530.0, 5530.0, 5530.0, 5530.0)
*/
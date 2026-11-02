-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (5, '610', '610', 611, '1001-09-03');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (4, '610', '610', 610, '1001-09-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MIN(amount) FROM sales;

/*
Prediction Result:
(610.0,)
*/
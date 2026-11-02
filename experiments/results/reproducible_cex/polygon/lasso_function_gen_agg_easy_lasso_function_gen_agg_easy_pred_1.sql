-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (5, '797', '797', -145, '1002-03-09');
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (4, '797', '797', 797, '1002-03-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MAX(amount) FROM sales;

/*
Prediction Result:
(797.0,)
*/
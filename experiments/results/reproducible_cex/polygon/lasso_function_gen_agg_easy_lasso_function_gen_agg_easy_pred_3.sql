-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-9532, '-9532', '-9532', -9532, '0973-11-26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT AVG(amount) FROM sales;

/*
Prediction Result:
(-9532.0,)
*/
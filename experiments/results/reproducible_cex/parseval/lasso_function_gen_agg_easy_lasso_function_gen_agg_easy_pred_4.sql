-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sales --
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, '2025-04-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT amount FROM sales;

/*
Prediction Result:
(874.871895,)
*/
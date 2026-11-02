-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (1001, 'Allison Hill', 'dog', 1002.5, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(amount) FROM sales;

/*
Prediction Result:
(1002.5,)
*/
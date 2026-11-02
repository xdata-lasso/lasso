-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (7, NULL, '9', 848, 797, 10);
INSERT INTO "Products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (6, NULL, '12', 853, 803, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM Products WHERE price + cost > 50;

/*
Prediction Result:
(None,)
(None,)
*/
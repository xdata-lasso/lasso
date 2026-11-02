-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "name", "category", "price", "cost", "stock_quantity") VALUES (1001, 'Allison Hill', 'dog', 0.0, -51.0, 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price + cost > 50;

/*
Prediction Result:
*/
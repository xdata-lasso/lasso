-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, cost, stock_quantity) VALUES (1, 'default2', NULL, 0.0, 50.0, 1), (50, 'default1', 'default2', 51.0, 50.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Products WHERE price * cost > 50;

/*
Prediction Result:
('default1',)
*/
-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (1, 'Product A', 'Category 1', 10.0, 10.0, 5);
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
('Product A',)
*/
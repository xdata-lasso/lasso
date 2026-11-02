-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (1, 'ExactBoundary', 'Electronics', 100.0, 50.0, 10);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (2, 'JustAboveFloat', 'Electronics', 100.01, 50.0, 10);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (3, 'JustBelowFloat', 'Electronics', 99.99, 50.0, 10);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (4, 'JustAboveInt', 'Electronics', 101.0, 50.0, 10);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (5, 'JustBelowInt', 'Electronics', 99.0, 50.0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
('JustAboveFloat',)
('JustAboveInt',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price / cost > 50;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (1, 'ExactBoundary', 'Electronics', 100.0, 50.0, 10);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (2, 'JustAboveFloat', 'Electronics', 100.5, 50.0, 5);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (3, 'JustBelowFloat', 'Electronics', 99.5, 50.0, 5);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (4, 'JustAboveInt', 'Books', 101.0, 50.0, 20);
INSERT INTO Products (product_id, name, category, price, cost, stock_quantity) VALUES (5, 'JustBelowInt', 'Books', 99.0, 50.0, 20);
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
SELECT name FROM Products WHERE price + cost > 50;

/*
Prediction Result:
('ExactBoundary',)
('JustAboveFloat',)
('JustBelowFloat',)
('JustAboveInt',)
('JustBelowInt',)
*/
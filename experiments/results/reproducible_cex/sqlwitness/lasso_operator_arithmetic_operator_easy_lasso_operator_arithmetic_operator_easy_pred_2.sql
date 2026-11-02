-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, cost REAL, stock_quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, cost, stock_quantity) VALUES (0, NULL, 'default2', 1.0, 0.0, 50), (50, 'default2', 'default1', 0.0, NULL, 51), (49, NULL, NULL, 50.0, 50.0, 0), (1, 'default2', NULL, 51.0, 49.0, 1), (51, NULL, NULL, 51.0, 0.0, 0), (2, 'default1', NULL, 50.0, 0.0, 51), (3, 'default1', 'default1', 49.0, 1.0, 0), (4, 'default2', 'default2', 51.0, 1.0, 49), (5, 'default1', 'default2', 0.0, 1.0, 50), (6, 'default2', 'default2', 1.0, 51.0, 51), (7, NULL, 'default2', 0.0, 50.0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM Products WHERE price / cost > 50;

/*
Prediction Result:
('default2',)
*/
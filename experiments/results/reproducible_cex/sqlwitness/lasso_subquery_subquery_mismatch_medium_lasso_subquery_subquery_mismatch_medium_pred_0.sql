-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (0, NULL, 'Electronics', 1.0, 1), (1, 'default1', 'default1', 1.0, 1), (2, NULL, 'Electronics', NULL, 1), (3, 'default1', NULL, NULL, NULL), (4, 'default1', 'Electronics', 1.0, 1), (5, 'default1', 'default2', NULL, 1), (6, 'Electronics', 'default1', 0.0, 1), (7, 'Electronics', NULL, 0.0, 0), (8, 'default2', NULL, 1.0, 1), (9, 'Electronics', 'default1', NULL, 1), (10, NULL, 'Electronics', 1.0, NULL), (11, 'default1', NULL, NULL, 1), (12, 'default1', 'Electronics', 0.0, 1), (13, 'Electronics', 'default2', 1.0, NULL), (14, 'default2', 'default2', 0.0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price > (SELECT MIN(price) FROM Products WHERE category = 'Electronics');

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
(None,)
('Electronics',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > (SELECT MAX(price) FROM Products WHERE category = 'Electronics');

/*
Prediction Result:
*/
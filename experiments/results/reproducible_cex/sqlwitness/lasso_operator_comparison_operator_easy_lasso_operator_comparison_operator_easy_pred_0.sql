-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (99, 'default2', NULL, 100.0, 0), (1, NULL, 'default2', 100.0, 99), (101, 'default2', NULL, 0.0, 100), (0, NULL, 'default2', NULL, 0), (100, NULL, NULL, 0.0, NULL), (2, NULL, NULL, 1.0, 1), (3, 'default1', 'default1', 99.0, NULL), (4, 'default2', NULL, 99.0, 0), (5, 'default2', 'default1', 99.0, NULL), (6, 'default2', 'default1', 1.0, 0), (7, 'default1', NULL, 100.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price >= 100;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > 100;

/*
Prediction Result:
*/
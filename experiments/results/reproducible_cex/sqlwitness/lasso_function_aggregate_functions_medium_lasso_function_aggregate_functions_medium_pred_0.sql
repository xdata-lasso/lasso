-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (0, 'Electronics', NULL, 0.0, NULL), (1, 'Electronics', 'Electronics', 0.0, 1), (2, 'default1', 'default1', NULL, 0), (3, 'Electronics', 'default1', 1.0, NULL), (4, 'default1', 'default2', 1.0, NULL), (5, 'default1', NULL, 0.0, NULL), (6, 'Electronics', NULL, 1.0, NULL), (7, 'default1', NULL, NULL, NULL), (8, NULL, 'default2', 1.0, NULL), (9, NULL, 'default2', NULL, 1), (10, 'Electronics', 'Electronics', 1.0, 0), (11, 'Electronics', 'Electronics', 1.0, 0), (12, 'default2', 'Electronics', 0.0, 0), (13, 'default2', 'default2', 0.0, 1), (14, 'default1', 'Electronics', 1.0, 1), (15, NULL, 'Electronics', NULL, 0), (16, 'Electronics', 'default1', 0.0, 1), (17, NULL, 'Electronics', 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(price) FROM Products WHERE category = 'Electronics';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT MAX(price) FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
(1.0,)
*/
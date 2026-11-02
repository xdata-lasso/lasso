-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (0, 'default1', 'default1', NULL, 9), (10, NULL, 'default2', 9.0, 11), (9, 'default1', 'default1', 10.0, 0), (11, 'default2', 'default1', 10.0, NULL), (1, 'default2', 'default1', 10.0, 1), (2, NULL, NULL, 0.0, 0), (3, 'default2', 'default1', NULL, 10), (4, 'default2', 'default2', 9.0, 1), (5, NULL, 'default2', NULL, 11), (6, 'default1', 'default2', 10.0, 11), (7, NULL, 'default1', 0.0, 0), (8, NULL, 'default2', 1.0, 1), (12, 'default1', NULL, NULL, 1), (13, 'default1', 'default2', 1.0, 0), (14, 'default1', NULL, 1.0, 10);
INSERT INTO users (user_id, name, email, registration_date, is_active) VALUES (9, 'default2', 'default1', '2023-01-01', 0), (1, NULL, 'default2', '2023-01-01', 1), (11, 'default1', NULL, '2023-01-01', 10), (10, NULL, NULL, NULL, 10);
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES (11, NULL, '2023-01-01', 10.0, 'default1');
INSERT INTO orderitems (order_item_id, product_id, order_id, quantity, unit_price) VALUES (1, 3, NULL, 9, 9.0), (11, 3, NULL, 1, 9.0), (0, 13, NULL, 10, 9.0), (10, 9, 11, 10, 11.0), (9, 9, 11, 10, 1.0), (2, 5, NULL, 11, 9.0), (3, 8, 11, 9, 1.0), (4, 14, 11, 9, NULL), (5, 0, NULL, 0, 11.0), (6, 13, 11, 11, 10.0), (7, 13, NULL, 11, 0.0), (8, 3, NULL, 9, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT p.name FROM Products AS p JOIN OrderItems AS i ON p.product_id = i.product_id WHERE i.quantity > 10;

/*
Prediction Result:
(None,)
('default1',)
('default1',)
*/
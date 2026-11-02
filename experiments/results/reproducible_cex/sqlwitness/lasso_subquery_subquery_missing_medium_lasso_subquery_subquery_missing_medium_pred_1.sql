-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (2, NULL, 'default1', 10.0, 4), (4, 'default1', 'default2', 3.0, 0), (10, 'default2', NULL, 1.0, 1);
INSERT INTO users (user_id, name, email, registration_date, is_active) VALUES (3, 'default1', 'default2', '2023-01-01', 10), (4, NULL, 'default1', '2023-01-01', 3);
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES (9, 3, '2023-01-02', 4.0, NULL), (3, 4, NULL, 0.0, NULL);
INSERT INTO orderitems (order_item_id, product_id, order_id, quantity, unit_price) VALUES (0, 4, NULL, 2, 10.0), (1, 2, NULL, 10, 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Products WHERE product_id IN (1, 2, 3);

/*
Prediction Result:
(None,)
*/
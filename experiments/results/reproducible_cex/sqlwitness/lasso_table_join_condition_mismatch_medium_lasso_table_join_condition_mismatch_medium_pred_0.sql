-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, name, category, price, stock_quantity) VALUES (1, 'default2', NULL, 0.0, 0);
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES (1, NULL, '2023-01-01', NULL, 'default2'), (0, NULL, '2023-01-01', 0.0, 'default2');
INSERT INTO orderitems (order_item_id, product_id, order_id, quantity, unit_price) VALUES (1, NULL, 1, 1, 1.0), (0, 1, 1, NULL, 1.0), (2, 1, 1, 0, NULL), (3, NULL, 1, 0, 0.0), (4, 1, 1, 1, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('2023-01-01', None)
('2023-01-01', 1)
('2023-01-01', 0)
('2023-01-01', 0)
('2023-01-01', 1)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.user_id = i.product_id;

/*
Prediction Result:
*/